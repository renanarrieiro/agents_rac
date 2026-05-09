*&---------------------------------------------------------------------*
*& Classe de exceção customizada para erros de Transfer Order
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  PUBLIC
  INHERITING FROM cx_root
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    CONSTANTS:
      BEGIN OF error_codes,
        insufficient_stock   TYPE symsgid VALUE 'ZTO_ERRO',
        position_mismatch   TYPE symsgid VALUE 'ZTO_ERRO',
        system_error        TYPE symsgid VALUE 'ZTO_ERRO',
        validation_error    TYPE symsgid VALUE 'ZTO_ERRO',
        business_error      TYPE symsgid VALUE 'ZTO_ERRO',
      END OF error_codes.

    METHODS:
      constructor
        IMPORTING
          !textid   LIKE if_t100_message=>t100key OPTIONAL
          !previous LIKE previous OPTIONAL
          !bauret2  TYPE bapiret2 OPTIONAL
          !log_no   TYPE balnre OPTIONAL
          !log_msg_no TYPE balmsgno OPTIONAL.

    DATA:
      bauret2    TYPE bapiret2 READ-ONLY,
      log_no     TYPE balnre READ-ONLY,
      log_msg_no TYPE balmsgno READ-ONLY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

*&---------------------------------------------------------------------*
*& Implementação da classe de exceção
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).

    IF bauret2 IS NOT INITIAL.
      me->bauret2 = bauret2.
    ENDIF.

    IF log_no IS NOT INITIAL.
      me->log_no = log_no.
    ENDIF.

    IF log_msg_no IS NOT INITIAL.
      me->log_msg_no = log_msg_no.
    ENDIF.
  ENDMETHOD.
ENDCLASS.