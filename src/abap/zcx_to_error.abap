*&---------------------------------------------------------------------*
*& Classe de exceção customizada para transações de Transfer Order
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  PUBLIC
  INHERITING FROM cx_root
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !msg_type TYPE bapiret2-type DEFAULT 'E'
        !msg_id   TYPE bapiret2-id DEFAULT 'ZTO'
        !msg_number TYPE bapiret2-number
        !msg_text TYPE bapiret2-message OPTIONAL
        !msg_v1 TYPE bapiret2-message_v1 OPTIONAL
        !msg_v2 TYPE bapiret2-message_v2 OPTIONAL
        !msg_v3 TYPE bapiret2-message_v3 OPTIONAL
        !msg_v4 TYPE bapiret2-message_v4 OPTIONAL.

    DATA:
      msg_type   TYPE bapiret2-type,
      msg_id     TYPE bapiret2-id,
      msg_number TYPE bapiret2-number,
      msg_text   TYPE bapiret2-message,
      msg_v1     TYPE bapiret2-message_v1,
      msg_v2     TYPE bapiret2-message_v2,
      msg_v3     TYPE bapiret2-message_v3,
      msg_v4     TYPE bapiret2-message_v4,
      log_no     TYPE bapiret2-log_no,
      log_msg_no TYPE bapiret2-log_msg_no.

  PRIVATE SECTION.
    CLASS-DATA:
      message_text TYPE string.

ENDCLASS.

*&---------------------------------------------------------------------*
*& Implementação da classe de exceção
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.

  METHOD constructor.
    super->constructor( textid = textid previous = previous ).

    me->msg_type   = msg_type.
    me->msg_id     = msg_id.
    me->msg_number = msg_number.
    me->msg_text   = msg_text.
    me->msg_v1     = msg_v1.
    me->msg_v2     = msg_v2.
    me->msg_v3     = msg_v3.
    me->msg_v4     = msg_v4.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.

ENDCLASS.