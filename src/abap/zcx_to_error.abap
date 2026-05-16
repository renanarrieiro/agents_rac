*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR
*&---------------------------------------------------------------------*
*
*       Classe de exceção customizada para erros de Transfer Order
*       (baixa de lubrificantes)
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
        !previous  LIKE previous OPTIONAL
        !matnr     TYPE matnr OPTIONAL
        !werks     TYPE werks_d OPTIONAL
        !lgort     TYPE lgort_d OPTIONAL
        !message   TYPE string OPTIONAL
        !bapiret2  TYPE bapiret2 OPTIONAL
        !log_no    TYPE balnre OPTIONAL
        !log_msg_no TYPE balmsgno OPTIONAL.

    DATA:
      matnr     TYPE matnr,
      werks     TYPE werks_d,
      lgort     TYPE lgort_d,
      message   TYPE string,
      bapiret2  TYPE bapiret2,
      log_no    TYPE balnre,
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
    me->message = message.
    me->bapiret2 = bapiret2.
    me->log_no = log_no.
    me->log_msg_no = log_msg_no.
  ENDMETHOD.
ENDCLASS.