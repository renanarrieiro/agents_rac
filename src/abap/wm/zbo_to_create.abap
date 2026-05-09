*&---------------------------------------------------------------------*
*& Include           ZBO_TO_CREATE_CLS
*&---------------------------------------------------------------------*

CLASS zcl_bo_to_create DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_create_success,
             tanum   TYPE tanum,
             tapos   TYPE tapos,
             messages TYPE bapiret2_tab,
           END OF ty_create_success.

    METHODS create
      IMPORTING
        !iv_squit TYPE c OPTIONAL
      RETURNING
        VALUE(ro_result) TYPE REF TO ty_create_success
      RAISING
        cx_sy_arithmetic_error
        cx_sy_conversion_error
        cx_sy_dyn_call_error
        cx_sy_parameter_not_found
        cx_sy_subrc_not_0.

  PRIVATE SECTION.
    METHODS _call_fm_to_create
      IMPORTING
        !iv_squit TYPE c
      RETURNING
        VALUE(rv_tanum) TYPE tanum
      RAISING
        cx_sy_arithmetic_error
        cx_sy_conversion_error
        cx_sy_dyn_call_error
        cx_sy_parameter_not_found
        cx_sy_subrc_not_0.

    METHODS _handle_messages
      IMPORTING
        !iv_tanum   TYPE tanum
        !iv_tapos   TYPE tapos
      RETURNING
        VALUE(rt_messages) TYPE bapiret2_tab.

ENDCLASS.

*&---------------------------------------------------------------------*
*& Class (Implementation)       ZCL_BO_TO_CREATE
*&---------------------------------------------------------------------*

CLASS zcl_bo_to_create IMPLEMENTATION.

  METHOD create.
    DATA: lv_tanum   TYPE tanum,
          lv_tapos   TYPE tapos,
          lt_messages TYPE bapiret2_tab.

    " Chamar o FM L_TO_CREATE_SINGLE
    lv_tanum = _call_fm_to_create( iv_squit ).

    " Obter o número do item (TAPOS) - pode vir do retorno do FM ou ser calculado
    lv_tapos = '0001'. " Valor padrão, pode ser ajustado conforme necessidade

    " Tratar mensagens
    lt_messages = _handle_messages( lv_tanum, lv_tapos ).

    " Montar estrutura de retorno
    ro_result = NEW #( ).
    ro_result->tanum   = lv_tanum.
    ro_result->tapos   = lv_tapos.
    ro_result->messages = lt_messages.

  ENDMETHOD.

  METHOD _call_fm_to_create.
    DATA: ls_to_create_single TYPE l_to_create_single,
          ls_return           TYPE bapiret2,
          lv_subrc            TYPE sy-subrc.

    " Preencher parâmetros fixos e variáveis conforme EF
    " Campos obrigatórios do FM L_TO_CREATE_SINGLE
    ls_to_create_single-lgnum   = '1001'. " Número do armazém - valor fixo conforme EF
    ls_to_create_single-lgtyp   = '601'.  " Tipo de TO - valor fixo conforme EF
    ls_to_create_single-matnr   = 'LUBRIF001'. " Material - valor fixo conforme EF
    ls_to_create_single-werks   = '1000'. " Centro - valor fixo conforme EF
    ls_to_create_single-lgort   = '0010'. " Local de armazenamento - valor fixo conforme EF
    ls_to_create_single-charg   = 'BATCH001'. " Número de lote - valor fixo conforme EF
    ls_to_create_single-batch   = 'BATCH001'. " Número de lote (alternativo)
    ls_to_create_single-qty     = '1'.    " Quantidade - valor fixo conforme EF
    ls_to_create_single-meins   = 'UN'.   " Unidade de medida - valor fixo conforme EF
    ls_to_create_single-squit   = iv_squit. " Indicador de confirmação

    " Campos opcionais conforme necessidade
    ls_to_create_single-vbeln   = '4500001234'. " Documento de referência
    ls_to_create_single-posnr   = '00010'.       " Posição do documento

    " Chamar o FM L_TO_CREATE_SINGLE
    CALL FUNCTION 'L_TO_CREATE_SINGLE'
      EXPORTING
        to_create_single = ls_to_create_single
      IMPORTING
        tanum            = rv_tanum
        tapos            = ls_return-tapos
      TABLES
        return           = ls_return
      EXCEPTIONS
        OTHERS           = 1.

    " Verificar se houve erro
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_sy_subrc_not_0
        WITH MESSAGE TEXT-001. " Erro ao criar TO
    ENDIF.

    " Verificar mensagens de erro no retorno
    IF ls_return-type = 'E' OR ls_return-type = 'A'.
      RAISE EXCEPTION TYPE cx_sy_subrc_not_0
        WITH MESSAGE ls_return-message.
    ENDIF.

  ENDMETHOD.

  METHOD _handle_messages.
    DATA: ls_message TYPE bapiret2.

    " Adicionar mensagem de sucesso
    ls_message-type   = 'S'.
    ls_message-id     = 'ZWM'.
    ls_message-number = '000'.
    ls_message-message = |TO criada com sucesso: { iv_tanum } - { iv_tapos }|.
    APPEND ls_message TO rt_messages.

    " Adicionar mensagem de confirmação se aplicável
    IF iv_tapos = '0001'.
      ls_message-type   = 'S'.
      ls_message-id     = 'ZWM'.
      ls_message-number = '001'.
      ls_message-message = 'Item confirmado automaticamente.'.
      APPEND ls_message TO rt_messages.
    ENDIF.

  ENDMETHOD.

ENDCLASS.