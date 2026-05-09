*&---------------------------------------------------------------------*
*&  Class ZCL_TO_ERROR_HANDLER
*&---------------------------------------------------------------------*
*   Classe de tratamento de erros para Transfer Order com logging via SLG1
*&---------------------------------------------------------------------*
CLASS zcl_to_error_handler DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      "! Construtor
      constructor
        IMPORTING
          !iv_object   TYPE balobj_d
          !iv_subobj   TYPE balsubobj_d
          !iv_log_handle TYPE balloghndl OPTIONAL,

      "! Registra erro no Application Log (SLG1)
      "! @param iv_msgid   ID da mensagem
      "! @param iv_msgno   Número da mensagem
      "! @param iv_msgty   Tipo da mensagem (E=Erro, W=Aviso, I=Informação)
      "! @param iv_msgv1   Variável 1 da mensagem
      "! @param iv_msgv2   Variável 2 da mensagem
      "! @param iv_msgv3   Variável 3 da mensagem
      "! @param iv_msgv4   Variável 4 da mensagem
      "! @param iv_msgtxt  Texto da mensagem
      METHODS log_error
        IMPORTING
          !iv_msgid   TYPE balmsgv1
          !iv_msgno   TYPE balmsgv2
          !iv_msgty   TYPE balmsgv3
          !iv_msgv1   TYPE balmsgv4
          !iv_msgv2   TYPE balmsgv5
          !iv_msgv3   TYPE balmsgv6
          !iv_msgv4   TYPE balmsgv7
          !iv_msgtxt  TYPE balognl OPTIONAL,

      "! Processa retorno BAPIRET2 e registra erro se necessário
      "! @param is_return   Estrutura BAPIRET2
      "! @param iv_matnr    Material
      "! @param iv_werks    Centro
      "! @param iv_lgort    Local de armazenamento
      METHODS process_bapiret2
        IMPORTING
          !is_return   TYPE bapiret2
          !iv_matnr    TYPE matnr OPTIONAL
          !iv_werks    TYPE werks_d OPTIONAL
          !iv_lgort    TYPE lgort_d OPTIONAL,

      "! Levanta exceção de negócio com base no retorno BAPIRET2
      "! @param is_return   Estrutura BAPIRET2
      "! @param iv_matnr    Material
      "! @param iv_werks    Centro
      "! @param iv_lgort    Local de armazenamento
      METHODS raise_business_exception
        IMPORTING
          !is_return   TYPE bapiret2
          !iv_matnr    TYPE matnr OPTIONAL
          !iv_werks    TYPE werks_d OPTIONAL
          !iv_lgort    TYPE lgort_d OPTIONAL,

      "! Obtém o handle do log
      "! @return          Handle do log
      METHODS get_log_handle
        RETURNING
          VALUE(rv_log_handle) TYPE balloghndl.

  PRIVATE SECTION.
    DATA:
      mo_log      TYPE REF TO cl_bal_logger,
      mv_object   TYPE balobj_d,
      mv_subobj   TYPE balsubobj_d,
      mv_log_handle TYPE balloghndl.

    METHODS:
      "! Inicializa o log
      initialize_log
        RAISING
          cx_bal_runtime_error.

ENDCLASS.

*&---------------------------------------------------------------------*
*&  Class ZCL_TO_ERROR_HANDLER IMPLEMENTATION
*&---------------------------------------------------------------------*
CLASS zcl_to_error_handler IMPLEMENTATION.
  METHOD constructor.
    mv_object   = iv_object.
    mv_subobj   = iv_subobj.
    mv_log_handle = iv_log_handle.
    
    IF mv_log_handle IS INITIAL.
      initialize_log( ).
    ENDIF.
  ENDMETHOD.

  METHOD initialize_log.
    DATA: ls_log_header TYPE bal_s_log.

    ls_log_header-object   = mv_object.
    ls_log_header-subobject = mv_subobj.
    ls_log_header-aldate   = sy-datum.
    ls_log_header-altime   = sy-uzeit.
    ls_log_header-aluser   = sy-uname.
    ls_log_header-alprog   = sy-repid.
    ls_log_header-extnumber = |{ sy-datum TIME = sy-uzeit }|.

    mo_log = cl_bal_logger=>create_log_header(
      exporting
        i_s_log = ls_log_header
      importing
        e_log_handle = mv_log_handle
    ).
  ENDMETHOD.

  METHOD log_error.
    DATA: ls_msg TYPE bal_s_msg.

    ls_msg-msgty = iv_msgty.
    ls_msg-msgid = iv_msgid.
    ls_msg-msgno = iv_msgno.
    ls_msg-msgv1 = iv_msgv1.
    ls_msg-msgv2 = iv_msgv2.
    ls_msg-msgv3 = iv_msgv3.
    ls_msg-msgv4 = iv_msgv4.
    ls_msg-msgv4 = iv_msgtxt.

    IF mo_log IS BOUND.
      mo_log->add_message(
        exporting
          i_s_msg = ls_msg
      ).
    ENDIF.
  ENDMETHOD.

  METHOD process_bapiret2.
    IF is_return-type CA 'EA'.  " Erro ou Abort
      log_error(
        iv_msgid   = is_return-id
        iv_msgno   = is_return-number
        iv_msgty   = is_return-type
        iv_msgv1   = is_return-message_v1
        iv_msgv2   = is_return-message_v2
        iv_msgv3   = is_return-message_v3
        iv_msgv4   = is_return-message_v4
        iv_msgtxt  = is_return-message
      ).
    ENDIF.
  ENDMETHOD.

  METHOD raise_business_exception.
    IF is_return-type CA 'EA'.  " Erro ou Abort
      DATA(lv_message) = is_return-message.
      
      IF lv_message IS INITIAL.
        lv_message = 'Erro ao processar Transfer Order'.
      ENDIF.

      RAISE EXCEPTION TYPE zcx_to_error
        EXPORTING
          matnr    = iv_matnr
          werks    = iv_werks
          lgort    = iv_lgort
          message  = lv_message.
    ENDIF.
  ENDMETHOD.

  METHOD get_log_handle.
    rv_log_handle = mv_log_handle.
  ENDMETHOD.
ENDCLASS.