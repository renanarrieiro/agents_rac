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
        !message  TYPE string OPTIONAL
        !matnr    TYPE matnr OPTIONAL
        !werks    TYPE werks_d OPTIONAL
        !lgort    TYPE lgort_d OPTIONAL
        !tannum   TYPE tanum OPTIONAL
        !tapos    TYPE tapos OPTIONAL
        !bapiret2 TYPE bapiret2 OPTIONAL.

    DATA matnr TYPE matnr.
    DATA werks TYPE werks_d.
    DATA lgort TYPE lgort_d.
    DATA tannum TYPE tanum.
    DATA tapos TYPE tapos.
    DATA bapiret2 TYPE bapiret2.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR Implementation
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    me->matnr = matnr.
    me->werks = werks.
    me->lgort = lgort.
    me->tannum = tannum.
    me->tapos = tapos.
    me->bapiret2 = bapiret2.
    
    IF message IS NOT INITIAL.
      me->msgv1 = message.
    ENDIF.
  ENDMETHOD.
ENDCLASS.