*&---------------------------------------------------------------------*
*& Classe de exceção customizada para erros de Transfer Order
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
        !severity TYPE zif_to_error_handler=>ty_severity OPTIONAL.

    "! Atributos para armazenar informações do erro
    DATA:
      severity    TYPE zif_to_error_handler=>ty_severity READ-ONLY,
      custom_code TYPE string READ-ONLY,
      details     TYPE bapiret2_t READ-ONLY.

  PROTECTED SECTION.
  PRIVATE SECTION.
    "! Atributo para armazenar severidade do erro
    DATA mv_severity TYPE zif_to_error_handler=>ty_severity.
ENDCLASS.

*&---------------------------------------------------------------------*
*& Implementação da classe de exceção
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    
    " Armazenar mensagem personalizada
    IF message IS NOT INITIAL.
      me->msgv1 = message.
    ENDIF.
    
    " Armazenar severidade
    IF severity IS SUPPLIED.
      mv_severity = severity.
    ENDIF.
    
    " Definir texto padrão se não informado
    IF textid IS NOT SUPPLIED.
      textid = if_t100_message=>default_textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.