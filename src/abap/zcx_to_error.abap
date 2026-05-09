*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR
*&---------------------------------------------------------------------*
* Classe de exceção customizada para erros de Transfer Order de Lubrificantes
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  INHERITING FROM cx_static_check
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    CONSTANTS:
      BEGIN OF error_codes,
        insufficient_stock   TYPE symsgid VALUE 'ZTO',
        position_divergence  TYPE symsgid VALUE 'ZTO',
        to_creation_failed   TYPE symsgid VALUE 'ZTO',
        to_confirmation_failed TYPE symsgid VALUE 'ZTO',
        system_error        TYPE symsgid VALUE 'ZTO',
        invalid_parameters  TYPE symsgid VALUE 'ZTO',
        business_rule_violation TYPE symsgid VALUE 'ZTO'
      END OF error_codes.

    METHODS:
      constructor
        IMPORTING
          !textid   LIKE if_t100_message=>t100key OPTIONAL
          !previous LIKE previous OPTIONAL
          !message  TYPE string OPTIONAL
          !log_no   TYPE balnre OPTIONAL
          !log_msg_no TYPE balognr OPTIONAL
          !message_v1 TYPE any OPTIONAL
          !message_v2 TYPE any OPTIONAL
          !message_v3 TYPE any OPTIONAL
          !message_v4 TYPE any OPTIONAL.

    DATA:
      log_no        TYPE balnre,
      log_msg_no    TYPE balognr,
      message_v1    TYPE any,
      message_v2    TYPE any,
      message_v3    TYPE any,
      message_v4    TYPE any.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR IMPLEMENTATION
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    IF textid IS INITIAL.
      textid = if_t100_message=>default_textid.
    ENDIF.
    me->log_no = log_no.
    me->log_msg_no = log_msg_no.
    me->message_v1 = message_v1.
    me->message_v2 = message_v2.
    me->message_v3 = message_v3.
    me->message_v4 = message_v4.
    
    IF message IS NOT INITIAL.
      me->msgv1 = message.
    ENDIF.
  ENDMETHOD.
ENDCLASS.