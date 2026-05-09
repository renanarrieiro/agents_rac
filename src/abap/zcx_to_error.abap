*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR
*&---------------------------------------------------------------------*
*   Classe de exceção customizada para tratamento de erros de Transfer Order
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
        !message  TYPE string OPTIONAL.

    DATA:
      matnr    TYPE matnr,
      werks    TYPE werks_d,
      lgort    TYPE lgort_d,
      message  TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR IMPLEMENTATION
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    me->matnr  = matnr.
    me->werks  = werks.
    me->lgort  = lgort.
    me->message = message.
  ENDMETHOD.
ENDCLASS.