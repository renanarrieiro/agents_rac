*&---------------------------------------------------------------------*
*& Classe de exceção customizada para erros de Transfer Order
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !message  TYPE string OPTIONAL
        !error_code TYPE zto_error_code OPTIONAL.

    DATA error_code TYPE zto_error_code READ-ONLY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    me->error_code = error_code.
    IF message IS NOT INITIAL.
      me->msgv1 = message.
    ENDIF.
  ENDMETHOD.
ENDCLASS.