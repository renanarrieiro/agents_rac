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
        !tanim    TYPE tanim OPTIONAL
        !ta_posnr TYPE ta_posnr OPTIONAL.

    DATA matnr    TYPE matnr.
    DATA werks    TYPE werks_d.
    DATA lgort    TYPE lgort_d.
    DATA tanim    TYPE tanim.
    DATA ta_posnr TYPE ta_posnr.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR Implementation
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    me->matnr    = matnr.
    me->werks    = werks.
    me->lgort    = lgort.
    me->tanim    = tanim.
    me->ta_posnr = ta_posnr.
    
    IF message IS NOT INITIAL.
      me->if_t100_message~t100key-msgv1 = message.
    ENDIF.
  ENDMETHOD.
ENDCLASS.