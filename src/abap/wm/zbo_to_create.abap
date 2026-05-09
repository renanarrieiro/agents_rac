*&---------------------------------------------------------------------*
*& Include          ZBO_TO_CREATE_CLS
*&---------------------------------------------------------------------*

CLASS zbo_to_create DEFINITION
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
        VALUE(rv_result) TYPE ty_create_success
      RAISING
        cx_root.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS _call_fm_to_create
      IMPORTING
        !iv_squit TYPE c OPTIONAL
      RETURNING
        VALUE(rv_result) TYPE ty_create_success
      RAISING
        cx_root.

    METHODS _handle_messages
      IMPORTING
        !iv_tanum   TYPE tanum
        !iv_tapos   TYPE tapos
        !iv_squit   TYPE c
        !it_messages TYPE bapiret2_tab
      RETURNING
        VALUE(rv_result) TYPE ty_create_success.

    METHODS _validate_input
      IMPORTING
        !iv_squit TYPE c
      RAISING
        cx_root.
ENDCLASS.

*&---------------------------------------------------------------------*
*& Class (Implementation)  ZBO_TO_CREATE
*&---------------------------------------------------------------------*

CLASS zbo_to_create IMPLEMENTATION.
  METHOD create.
    DATA: lv_result TYPE ty_create_success.

    " Validação de entrada
    me->_validate_input( iv_squit ).

    " Chamar FM para criar TO
    lv_result = me->_call_fm_to_create( iv_squit ).

    " Tratar mensagens
    rv_result = me->_handle_messages(
      iv_tanum   = lv_result-tanum
      iv_tapos   = lv_result-tapos
      iv_squit   = iv_squit
      it_messages = lv_result-messages
    ).
  ENDMETHOD.

  METHOD _call_fm_to_create.
    DATA: ls_to_create  TYPE l_to_create_single,
          ls_to_header  TYPE l_to_header_single,
          ls_to_item    TYPE l_to_item_single,
          ls_to_control TYPE l_to_control_single,
          lt_messages   TYPE bapiret2_tab,
          lv_tanum      TYPE tanum,
          lv_tapos      TYPE tapos.

    " Preencher parâmetros fixos e variáveis conforme EF
    ls_to_header-lgnum = '1000'. " Número do armazém - valor fixo conforme EF
    ls_to_header-lgtyp = '601'.  " Tipo de TO - valor fixo conforme EF
    ls_to_header-werks = '1000'. " Centro - valor fixo conforme EF

    " Preencher itens da TO
    ls_to_item-matnr = 'LUBRIF001'. " Material - valor fixo conforme EF
    ls_to_item-batch = 'BATCH001'.  " Lote - valor fixo conforme EF
    ls_to_item-lgort = '0001'.      " Local de armazenamento - valor fixo conforme EF
    ls_to_item-qty   = '10'.        " Quantidade - valor fixo conforme EF

    " Preencher controle
    ls_to_control-immediate = iv_squit. " Se I_SQUIT = 'X', a TO nasce confirmada

    " Chamar FM L_TO_CREATE_SINGLE
    CALL FUNCTION 'L_TO_CREATE_SINGLE'
      EXPORTING
        i_to_header  = ls_to_header
        i_to_item    = ls_to_item
        i_to_control = ls_to_control
      IMPORTING
        e_tanum      = lv_tanum
        e_tapos      = lv_tapos
      TABLES
        t_messages   = lt_messages
      EXCEPTIONS
        error_message = 1
        OTHERS       = 2.

    " Tratar exceções
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_static_check
        MESSAGE ID 'L_TO_CREATE_SINGLE'
        TYPE 'E'
        NUMBER '001'
        WITH 'Erro ao criar TO'.
    ENDIF.

    " Retornar resultado
    rv_result-tanum   = lv_tanum.
    rv_result-tapos   = lv_tapos.
    rv_result-messages = lt_messages.
  ENDMETHOD.

  METHOD _handle_messages.
    DATA: lv_message TYPE string.

    " Adicionar mensagem de sucesso
    IF iv_tanum IS NOT INITIAL AND iv_tapos IS NOT INITIAL.
      lv_message = |TO criada com sucesso: { iv_tanum } - { iv_tapos }|.
      APPEND VALUE #( type = 'S' id = 'ZBO_TO_CREATE' number = '000' message = lv_message ) TO rv_result-messages.
    ENDIF.

    " Adicionar mensagem sobre confirmação
    IF iv_squit = 'X'.
      lv_message = 'TO criada e confirmada imediatamente.'.
      APPEND VALUE #( type = 'S' id = 'ZBO_TO_CREATE' number = '001' message = lv_message ) TO rv_result-messages.
    ELSE.
      lv_message = 'TO criada, aguardando confirmação separada.'.
      APPEND VALUE #( type = 'S' id = 'ZBO_TO_CREATE' number = '002' message = lv_message ) TO rv_result-messages.
    ENDIF.

    " Manter mensagens do FM
    rv_result-messages = VALUE #( BASE rv_result-messages
                                  ( LINES OF it_messages ) ).
  ENDMETHOD.

  METHOD _validate_input.
    " Validação básica do parâmetro I_SQUIT
    IF iv_squit IS NOT INITIAL AND iv_squit <> 'X'.
      RAISE EXCEPTION TYPE cx_static_check
        MESSAGE ID 'ZBO_TO_CREATE'
        TYPE 'E'
        NUMBER '001'
        WITH 'Parâmetro I_SQUIT deve ser vazio ou ''X'''.
    ENDIF.
  ENDMETHOD.
ENDCLASS.