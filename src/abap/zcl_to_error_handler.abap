*&---------------------------------------------------------------------*
*& Classe de tratamento de erros para Transfer Order (TO)
*&---------------------------------------------------------------------*
CLASS zcl_to_error_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      "! Processa mensagens de erro do BAPIRET2 e gera exceções customizadas
      "! @param bapiret2_tab Tabela de mensagens BAPIRET2
      "! @param operation Operação sendo executada (CREATE/CONFIRM)
      "! @return Exceção customizada se houver erro
      process_bapiret2_messages
        IMPORTING
          bapiret2_tab TYPE bapiret2_t
          operation    TYPE string
        RETURNING
          VALUE(result) TYPE REF TO zcx_to_error,

      "! Registra log de erro no SLG1 para erros de negócio
      "! @param error_code Código de erro
      "! @param message Mensagem de erro
      "! @param additional_info Informações adicionais
      log_business_error
        IMPORTING
          error_code      TYPE zto_error_code
          message         TYPE string
          additional_info TYPE string OPTIONAL,

      "! Verifica se há erros críticos que exigem rollback
      "! @param bapiret2_tab Tabela de mensagens BAPIRET2
      "! @return ABAP_TRUE se houver erro crítico
      has_critical_error
        IMPORTING
          bapiret2_tab TYPE bapiret2_t
        RETURNING
          VALUE(has_error) TYPE abap_bool,

      "! Formata mensagem BAPIRET2 para retorno estruturado
      "! @param bapiret2 Mensagem BAPIRET2 individual
      "! @return Mensagem formatada
      format_bapiret2_message
        IMPORTING
          bapiret2      TYPE bapiret2
        RETURNING
          VALUE(formatted_msg) TYPE string.

  PRIVATE SECTION.
    METHODS:
      "! Determina o tipo de erro com base na mensagem BAPIRET2
      "! @param bapiret2 Mensagem BAPIRET2
      "! @return Tipo de erro
      get_error_type
        IMPORTING
          bapiret2      TYPE bapiret2
        RETURNING
          VALUE(error_type) TYPE zto_error_type,

      "! Gera código de erro customizado
      "! @param operation Operação
      "! @param bapiret2 Mensagem BAPIRET2
      "! @return Código de erro
      generate_error_code
        IMPORTING
          operation     TYPE string
          bapiret2      TYPE bapiret2
        RETURNING
          VALUE(error_code) TYPE zto_error_code.
ENDCLASS.

CLASS zcl_to_error_handler IMPLEMENTATION.
  METHOD process_bapiret2_messages.
    DATA: lt_errors TYPE bapiret2_t,
          ls_error  TYPE bapiret2.

    " Filtra apenas mensagens de erro
    lt_errors = VALUE #( FOR ls_msg IN bapiret2_tab
                       WHERE ( type CA 'EA' )  " E=Error, A=Abort
                       ( ls_msg ) ).

    IF lt_errors IS NOT INITIAL.
      " Pega o primeiro erro para gerar a exceção
      READ TABLE lt_errors INTO ls_error INDEX 1.
      IF sy-subrc = 0.
        result = NEW zcx_to_error(
          textid   = if_t100_message=>default
          message  = format_bapiret2_message( ls_error )
          error_code = generate_error_code( operation = operation bapiret2 = ls_error )
        ).
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD log_business_error.
    DATA: ls_slg1 TYPE bal_s_log.

    " Configuração do log
    ls_slg1-aluser = sy-uname.
    ls_slg1-alprog = sy-repid.
    ls_slg1-aldate = sy-datum.
    ls_slg1-altime = sy-uzeit.
    ls_slg1-alobject = 'WM-TO'.
    ls_slg1-alsubobj = operation.
    ls_slg1-extnumber = error_code.
    ls_slg1-alreason = 'BUSINESS_ERROR'.
    ls_slg1-altext = message.

    " Adiciona informações adicionais se existirem
    IF additional_info IS NOT INITIAL.
      ls_slg1-altext = ls_slg1-altext && ' - ' && additional_info.
    ENDIF.

    " Registra o log
    CALL FUNCTION 'BAL_LOG_SAVE'
      EXPORTING
        i_s_log = ls_slg1
      EXCEPTIONS
        error_message = 1
        OTHERS         = 2.

    IF sy-subrc <> 0.
      " Log de fallback em caso de falha no SLG1
      MESSAGE 'Erro ao registrar log de negócio' TYPE 'E'.
    ENDIF.
  ENDMETHOD.

  METHOD has_critical_error.
    DATA: ls_error TYPE bapiret2.

    " Verifica por erros críticos: estoque insuficiente, divergência de posições, etc.
    LOOP AT bapiret2_tab INTO ls_error WHERE ( type = 'E' OR type = 'A' ).
      CASE ls_error-id.
        WHEN 'M7' OR 'WM' OR 'L_TO'. " Erros típicos de WM e TO
          has_error = abap_true.
          EXIT.
        WHEN OTHERS.
          IF ls_error-number BETWEEN '001' AND '099'.
            has_error = abap_true.
            EXIT.
          ENDIF.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD format_bapiret2_message.
    DATA: lv_message TYPE string.

    " Formata a mensagem com todos os campos relevantes
    CONCATENATE
      ls_bapiret2-type
      ls_bapiret2-id
      ls_bapiret2-number
      ls_bapiret2-message
      INTO lv_message
      SEPARATED BY space.

    " Adiciona informações de log se existirem
    IF ls_bapiret2-log_no IS NOT INITIAL AND ls_bapiret2-log_msg_no IS NOT INITIAL.
      CONCATENATE lv_message '(Log:' ls_bapiret2-log_no '-' ls_bapiret2-log_msg_no ')' INTO lv_message.
    ENDIF.

    formatted_msg = lv_message.
  ENDMETHOD.

  METHOD get_error_type.
    " Determina o tipo de erro com base na mensagem BAPIRET2
    CASE bapiret2-id.
      WHEN 'M7' OR 'WM'.
        error_type = zto_error_type-stock.
      WHEN 'L_TO'.
        error_type = zto_error_type-position.
      WHEN 'BAPI'.
        error_type = zto_error_type-bapi.
      WHEN OTHERS.
        error_type = zto_error_type-unknown.
    ENDCASE.
  ENDMETHOD.

  METHOD generate_error_code.
    DATA: lv_prefix TYPE string.

    " Gera prefixo baseado na operação
    CASE operation.
      WHEN 'CREATE'.
        lv_prefix = 'TO_CREATE'.
      WHEN 'CONFIRM'.
        lv_prefix = 'TO_CONFIRM'.
      WHEN OTHERS.
        lv_prefix = 'TO'.
    ENDCASE.

    " Gera código completo
    CONCATENATE lv_prefix '_' bapiret2-id '_' bapiret2-number INTO error_code.
    TRANSLATE error_code TO UPPER CASE.
  ENDMETHOD.
ENDCLASS.