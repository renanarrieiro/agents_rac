*&---------------------------------------------------------------------*
*& Classe de exceção customizada para erros de Transfer Order
*&---------------------------------------------------------------------*
CLASS zcx_to_error DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    CONSTANTS:
      BEGIN OF business_error,
        msgid   TYPE symsgid VALUE 'ZTO',
        msgno   TYPE symsgno VALUE '001',
        attr1   TYPE scattr1 VALUE 'MATNR',
        attr2   TYPE scattr2 VALUE 'WERKS',
        attr3   TYPE scattr3 VALUE 'LGORT',
        attr4   TYPE scattr4 VALUE 'CHARG',
      END OF business_error,
      BEGIN OF system_error,
        msgid   TYPE symsgid VALUE 'ZTO',
        msgno   TYPE symsgno VALUE '002',
        attr1   TYPE scattr1 VALUE 'SUBRC',
        attr2   TYPE scattr2 VALUE 'FM_NAME',
        attr3   TYPE scattr3 VALUE 'ERROR_TEXT',
        attr4   TYPE scattr4 VALUE '',
      END OF system_error,
      BEGIN OF validation_error,
        msgid   TYPE symsgid VALUE 'ZTO',
        msgno   TYPE symsgno VALUE '003',
        attr1   TYPE scattr1 VALUE 'FIELD_NAME',
        attr2   TYPE scattr2 VALUE 'EXPECTED_VALUE',
        attr3   TYPE scattr3 VALUE 'ACTUAL_VALUE',
        attr4   TYPE scattr4 VALUE '',
      END OF validation_error,
      BEGIN OF inventory_error,
        msgid   TYPE symsgid VALUE 'ZTO',
        msgno   TYPE symsgno VALUE '004',
        attr1   TYPE scattr1 VALUE 'MATNR',
        attr2   TYPE scattr2 VALUE 'WERKS',
        attr3   TYPE scattr3 VALUE 'LGORT',
        attr4   TYPE scattr4 VALUE 'REQUIRED_QTY',
      END OF inventory_error,
      BEGIN OF position_error,
        msgid   TYPE symsgid MESSAGE ID 'ZTO' NUMBER '005',
        attr1   TYPE scattr1 VALUE 'FROM_LGORT',
        attr2   TYPE scattr2 VALUE 'TO_LGORT',
        attr3   TYPE scattr3 VALUE 'EXPECTED_POS',
        attr4   TYPE scattr4 VALUE 'ACTUAL_POS',
      END OF position_error.

    METHODS:
      constructor
        IMPORTING
          !textid   LIKE if_t100_message=>t100key OPTIONAL
          !previous LIKE previous OPTIONAL
          !bauret2  TYPE bapiret2 OPTIONAL
          !message  TYPE string OPTIONAL.

    DATA:
      bauret2 TYPE bapiret2 READ-ONLY,
      message TYPE string READ-ONLY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcx_to_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( textid = textid previous = previous ).
    me->bauret2 = bauret2.
    me->message = message.
  ENDMETHOD.
ENDCLASS.