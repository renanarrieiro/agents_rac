*&---------------------------------------------------------------------*
*& Classe de exceção customizada para erros de Transfer Order
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! Construtor padrão
    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !message  TYPE string OPTIONAL
        !error_code TYPE zto_error_code OPTIONAL.

    "! Atributos para armazenar informações do erro
    DATA:
      "! Código de erro customizado
      error_code TYPE zto_error_code,
      "! Mensagem detalhada
      error_message TYPE string,
      "! Tipo de erro (E=Erro, W=Aviso, I=Informação, S=Sucesso)
      error_type TYPE bapiret2-type,
      "! ID da mensagem
      error_id TYPE bapiret2-id,
      "! Número da mensagem
      error_number TYPE bapiret2-number,
      "! Número do log
      log_no TYPE bapiret2-log_no,
      "! Número da mensagem do log
      log_msg_no TYPE bapiret2-log_msg_no,
      "! Variáveis de mensagem V1-V4
      message_v1 TYPE bapiret2-message_v1,
      message_v2 TYPE bapiret2-message_v2,
      message_v3 TYPE bapiret2-message_v3,
      message_v4 TYPE bapiret2-message_v4.

  PRIVATE SECTION.
    "! Constantes para códigos de erro
    CONSTANTS:
      BEGIN OF error_codes,
        estoque_insuficiente TYPE zto_error_code VALUE '001',
        divergencia_posicoes TYPE zto_error_code VALUE '002',
        fm_create_error     TYPE zto_error_code VALUE '003',
        fm_confirm_error    TYPE zto_error_code VALUE '004',
        sistema_error       TYPE zto_error_code VALUE '005',
        validacao_error     TYPE zto_error_code VALUE '006',
      END OF error_codes.

ENDCLASS.

*&---------------------------------------------------------------------*
*& Implementação da classe de exceção
*&---------------------------------------------------------------------*
CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    me->error_code = error_code.
    me->error_message = message.
    
    "! Define tipo de erro padrão como 'E' (Erro)
    IF me->error_type IS INITIAL.
      me->error_type = 'E'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.