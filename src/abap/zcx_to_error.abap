*&---------------------------------------------------------------------*
*&  Class ZCX_TO_ERROR
*&---------------------------------------------------------------------*
*
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

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
        !tanim    TYPE tanum OPTIONAL
        !tapos    TYPE tapos OPTIONAL
        !bapiret2  TYPE bapiret2_t OPTIONAL.

    METHODS get_matnr
      RETURNING VALUE(matnr) TYPE matnr.

    METHODS get_werks
      RETURNING VALUE(werks) TYPE werks_d.

    METHODS get_lgort
      RETURNING VALUE(lgort) TYPE lgort_d.

    METHODS get_tanim
      RETURNING VALUE(tanim) TYPE tanum.

    METHODS get_tapos
      RETURNING VALUE(tapos) TYPE tapos.

    METHODS get_bapiret2
      RETURNING VALUE(bapiret2) TYPE bapiret2_t.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      matnr    TYPE matnr,
      werks    TYPE werks_d,
      lgort    TYPE lgort_d,
      tanim    TYPE tanum,
      tapos    TYPE tapos,
      bapiret2  TYPE bapiret2_t.

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
    me->tapos    = tapos.
    me->bapiret2 = bapiret2.
    
    IF message IS NOT INITIAL.
      me->if_t100_message~t100key-msgv1 = message.
    ENDIF.
  ENDMETHOD.

  METHOD get_matnr.
    matnr = me->matnr.
  ENDMETHOD.

  METHOD get_werks.
    werks = me->werks.
  ENDMETHOD.

  METHOD get_lgort.
    lgort = me->lgort.
  ENDMETHOD.

  METHOD get_tanim.
    tanim = me->tanim.
  ENDMETHOD.

  METHOD get_tapos.
    tapos = me->tapos.
  ENDMETHOD.

  METHOD get_bapiret2.
    bapiret2 = me->bapiret2.
  ENDMETHOD.

ENDCLASS.