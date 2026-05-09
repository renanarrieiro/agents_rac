*&---------------------------------------------------------------------*
*& Class ZCX_TO_ERROR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  INHERITING FROM cx_root
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !msg_type  TYPE bapiret2-type DEFAULT 'E'
        !msg_id    TYPE bapiret2-id DEFAULT 'ZWM'
        !msg_number TYPE bapiret2-number
        !msg_v1    TYPE bapiret2-message_v1 OPTIONAL
        !msg_v2    TYPE bapiret2-message_v2 OPTIONAL
        !msg_v3    TYPE bapiret2-message_v3 OPTIONAL
        !msg_v4    TYPE bapiret2-message_v4 OPTIONAL.

    METHODS get_bapireturn
      RETURNING
        VALUE(rs_return) TYPE bapiret2.

    METHODS get_log_data
      RETURNING
        VALUE(rs_log_data) TYPE bal_s_log.

  PROTECTED SECTION.
    DATA: ms_bapireturn TYPE bapiret2,
          ms_log_data   TYPE bal_s_log.

  PRIVATE SECTION.
    CLASS-DATA: gv_log_counter TYPE i VALUE 0.
ENDCLASS.

*&---------------------------------------------------------------------*
*& Class ZCX_TO_ERROR IMPLEMENTATION
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.

  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    
    " Initialize BAPI return structure
    ms_bapireturn-type = msg_type.
    ms_bapireturn-id = msg_id.
    ms_bapireturn-number = msg_number.
    ms_bapireturn-message_v1 = msg_v1.
    ms_bapireturn-message_v2 = msg_v2.
    ms_bapireturn-message_v3 = msg_v3.
    ms_bapireturn-message_v4 = msg_v4.
    
    " Initialize log data
    ms_log_data-alprog = sy-repid.
    ms_log_data-aldate = sy-datum.
    ms_log_data-altime = sy-uzeit.
    ms_log_data-aluser = sy-uname.
    ms_log_data-alnum = gv_log_counter.
    ADD 1 TO gv_log_counter.
    
    " Set message text
    IF textid IS NOT INITIAL.
      MESSAGE ID textid-msgid TYPE textid-msgty NUMBER textid-msgno
        WITH textid-msgv1 textid-msgv2 textid-msgv3 textid-msgv4
        INTO ms_bapireturn-message.
    ELSE.
      MESSAGE ID msg_id TYPE msg_type NUMBER msg_number
        WITH msg_v1 msg_v2 msg_v3 msg_v4
        INTO ms_bapireturn-message.
    ENDIF.
  ENDMETHOD.

  METHOD get_bapireturn.
    rs_return = ms_bapireturn.
  ENDMETHOD.

  METHOD get_log_data.
    rs_log_data = ms_log_data.
  ENDMETHOD.

ENDCLASS.