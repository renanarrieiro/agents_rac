*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR
*&---------------------------------------------------------------------*
* Classe de exceção customizada para erros de Transfer Order
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
        !matnr    TYPE matnr OPTIONAL
        !werks    TYPE werks_d OPTIONAL
        !lgort    TYPE lgort_d OPTIONAL
        !to_number TYPE ebeln OPTIONAL
        !message  TYPE string OPTIONAL
        !log_no   TYPE balnre OPTIONAL
        !log_msg_no TYPE balmsgno OPTIONAL.

    DATA:
      matnr    TYPE matnr,
      werks    TYPE werks_d,
      lgort    TYPE lgort_d,
      to_number TYPE ebeln,
      message  TYPE string,
      log_no   TYPE balnre,
      log_msg_no TYPE balmsgno.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR IMPLEMENTATION
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    me->matnr = matnr.
    me->werks = werks.
    me->lgort = lgort.
    me->to_number = to_number.
    me->message = message.
    me->log_no = log_no.
    me->log_msg_no = log_msg_no.
  ENDMETHOD.
ENDCLASS.