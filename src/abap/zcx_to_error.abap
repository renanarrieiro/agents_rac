*&---------------------------------------------------------------------*
*& Classe de exceção customizada para erros de Transfer Order
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  PUBLIC
  INHERITING FROM cx_root
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !message  TYPE string OPTIONAL
        !error_code TYPE symsgid OPTIONAL.

    DATA error_code TYPE symsgid READ-ONLY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    me->error_code = error_code.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.