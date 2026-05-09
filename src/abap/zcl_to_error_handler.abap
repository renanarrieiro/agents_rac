*&---------------------------------------------------------------------*
*& Classe ZCL_TO_ERROR_HANDLER
*&---------------------------------------------------------------------*
*& Descrição: Handler para tratamento de erros e logging da API de baixa
*&            de lubrificantes utilizando SLG1 e BAPIRET2
*&---------------------------------------------------------------------*
CLASS zcl_to_error_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! Construtor
    METHODS constructor
      IMPORTING
        !iv_object   TYPE balobj_d DEFAULT 'ZTO'
        !iv_subobj   TYPE balobj_d DEFAULT 'LUBRIFICANTE'
        !iv_extnumber TYPE balnrext OPTIONAL.

    "! Processa mensagens BAPIRET2 e realiza logging via SLG1
    "! @parameter it_bapiret2 | Tabela de mensagens BAPIRET2
    "! @parameter iv_commit   | Indica se deve fazer commit após logging
    METHODS process_messages
      IMPORTING
        !it_bapiret2 TYPE bapiret2_tab
        !iv_commit   TYPE abap_bool DEFAULT abap_false.

    "! Cria mensagem de erro personalizado na classe ZCX_TO_ERROR
    "! @parameter iv_text     | Texto da mensagem
    "! @parameter iv_type     | Tipo da mensagem (E=Error, W=Warning, I=Info, S=Success)
    "! @parameter iv_number   | Número da mensagem
      METHODS create_error_message
        IMPORTING
          !iv_text   TYPE string
          !iv_type   TYPE bapi_msgty DEFAULT 'E'
          !iv_number TYPE symsgno DEFAULT '000'.

    "! Valida se há erros nas mensagens BAPIRET2
    "! @parameter it_bapiret2 | Tabela de mensagens BAPIRET2
    "! @return(abap_bool) | True se houver erros
    METHODS has_errors
      IMPORTING
        !it_bapiret2 TYPE bapiret2_tab
      RETURNING
        VALUE(rv_has_errors) TYPE abap_bool.

  PRIVATE SECTION.
    DATA: mo_logger TYPE REF TO zcl_to_error_handler,
          mv_object TYPE balobj_d,
          mv_subobj TYPE balobj_d,
          mv_extnumber TYPE balnrext.

    "! Cria log no SLG1
    "! @parameter iv_msgty   | Tipo da mensagem
    "! @parameter iv_msgv1   | Variável 1 da mensagem
    "! @parameter iv_msgv2   | Variável 2 da mensagem
    "! @parameter iv_msgv3   | Variável 3 da mensagem
    "! @parameter iv_msgv4   | Variável 4 da mensagem
    "! @parameter iv_msgid   | ID da mensagem
    "! @parameter iv_msgno   | Número da mensagem
    "! @parameter iv_msgv1   | Texto da mensagem
    METHODS create_log_entry
      IMPORTING
        !iv_msgty   TYPE balmsgty
        !iv_msgv1   TYPE any
        !iv_msgv2   TYPE any
        !iv_msgv3   TYPE any
        !iv_msgv4   TYPE any
        !iv_msgid   TYPE symsgid
        !iv_msgno   TYPE symsgno
        !iv_text    TYPE any.

ENDCLASS.

*&---------------------------------------------------------------------*
*& Classe ZCL_TO_ERROR_HANDLER - Implementação
*&---------------------------------------------------------------------*
CLASS zcl_to_error_handler IMPLEMENTATION.

  METHOD constructor.
    mv_object = iv_object.
    mv_subobj = iv_subobj.
    mv_extnumber = iv_extnumber.
  ENDMETHOD.

  METHOD process_messages.
    DATA: ls_bapiret2 TYPE bapiret2,
          lv_logno    TYPE ballogno,
          lv_log_msg_no TYPE balmsgno.

    LOOP AT it_bapiret2 INTO ls_bapiret2.
      " Determinar o número da mensagem no log
      lv_log_msg_no = sy-tabix.

      " Criar entrada no log SLG1
      me->create_log_entry(
        EXPORTING
          iv_msgty   = ls_bapiret2-type
          iv_msgv1   = ls_bapiret2-message_v1
          iv_msgv2   = ls_bapiret2-message_v2
          iv_msgv3   = ls_bapiret2-message_v3
          iv_msgv4   = ls_bapiret2-message_v4
          iv_msgid   = ls_bapiret2-id
          iv_msgno   = ls_bapiret2-number
          iv_text    = ls_bapiret2-message
      ).

      " Se for erro, lançar exceção
      IF ls_bapiret2-type CA 'EA'.
        RAISE EXCEPTION TYPE zcx_to_error
          EXPORTING
            textid   = zcx_to_error=>business_error
            previous = NEW zcx_to_error( text = ls_bapiret2-message )
            msgty    = ls_bapiret2-type
            msgid    = ls_bapiret2-id
            msgno    = ls_bapiret2-number
            msgv1    = ls_bapiret2-message_v1
            msgv2    = ls_bapiret2-message_v2
            msgv3    = ls_bapiret2-message_v3
            msgv4    = ls_bapiret2-message_v4.
      ENDIF.
    ENDLOOP.

    " Fazer commit se solicitado
    IF iv_commit = abap_true.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDMETHOD.

  METHOD create_error_message.
    DATA: ls_bapiret2 TYPE bapiret2.

    ls_bapiret2-type = iv_type.
    ls_bapiret2-id = 'ZTO'.
    ls_bapiret2-number = iv_number.
    ls_bapiret2-message = iv_text.
    ls_bapiret2-message_v1 = iv_text.
    ls_bapiret2-message_v2 = space.
    ls_bapiret2-message_v3 = space.
    ls_bapiret2-message_v4 = space.

    " Adicionar à tabela de mensagens
    APPEND ls_bapiret2 TO it_bapiret2.

    " Se for erro, lançar exceção
    IF iv_type CA 'EA'.
      RAISE EXCEPTION TYPE zcx_to_error
        EXPORTING
          textid   = zcx_to_error=>business_error
          previous = NEW zcx_to_error( text = iv_text )
          msgty    = iv_type
          msgid    = 'ZTO'
          msgno    = iv_number
          msgv1    = iv_text.
    ENDIF.
  ENDMETHOD.

  METHOD has_errors.
    DATA: ls_bapiret2 TYPE bapiret2.

    rv_has_errors = abap_false.
    LOOP AT it_bapiret2 INTO ls_bapiret2.
      IF ls_bapiret2-type CA 'EA'.
        rv_has_errors = abap_true.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD create_log_entry.
    DATA: ls_ballog TYPE bal_s_log,
          ls_balmsg TYPE bal_s_msg,
          lv_log_handle TYPE balloghndl.

    " Preparar cabeçalho do log
    ls_ballog-object = mv_object.
    ls_ballog-subobject = mv_subobj.
    ls_ballog-extnumber = mv_extnumber.
    ls_ballog-aldate = sy-datum.
    ls_ballog-altime = sy-uzeit.
    ls_ballog-aluser = sy-uname.
    ls_ballog-alprog = sy-repid.
    ls_ballog-altext = 'Log de Erros - Baixa de Lubrificantes'.

    " Adicionar mensagem ao log
    ls_balmsg-msgty = iv_msgty.
    ls_balmsg-msgv1 = iv_msgv1.
    ls_balmsg-msgv2 = iv_msgv2.
    ls_balmsg-msgv3 = iv_msgv3.
    ls_balmsg-msgv4 = iv_msgv4.
    ls_balmsg-msgid = iv_msgid.
    ls_balmsg-msgno = iv_msgno.
    ls_balmsg-msgv1 = iv_text.

    " Criar log no SLG1
    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log = ls_ballog
      IMPORTING
        e_log_handle = lv_log_handle
      EXCEPTIONS
        OTHERS = 1.

    IF sy-subrc = 0.
      " Adicionar mensagem ao log
      CALL FUNCTION 'BAL_LOG_MSG_ADD'
        EXPORTING
          i_log_handle = lv_log_handle
          i_s_msg      = ls_balmsg
        EXCEPTIONS
          OTHERS = 1.

      IF sy-subrc = 0.
        " Salvar log
        CALL FUNCTION 'BAL_DB_SAVE'
          EXPORTING
            i_save_all = abap_true
          EXCEPTIONS
            OTHERS = 1.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.