*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR
*&---------------------------------------------------------------------*
*
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
        !error_code TYPE zto_error_code OPTIONAL
        !error_type TYPE zto_error_type OPTIONAL
        !details  TYPE string OPTIONAL.

    DATA error_code TYPE zto_error_code READ-ONLY.
    DATA error_type TYPE zto_error_type READ-ONLY.
    DATA details TYPE string READ-ONLY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR IMPLEMENTATION
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).

    me->error_code = error_code.
    me->error_type = error_type.
    me->details = details.

    IF message IS NOT INITIAL.
      me->if_t100_message~t100key-msgv1 = message.
    ENDIF.
  ENDMETHOD.
ENDCLASS.