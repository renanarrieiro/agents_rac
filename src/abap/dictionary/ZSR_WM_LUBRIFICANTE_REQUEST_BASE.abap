*&---------------------------------------------------------------------*
*& Estrutura Base para Request de Serviço OData WM Baixa Lubrificante
*&---------------------------------------------------------------------*
*
* Estrutura: ZSR_WM_LUBRIFICANTE_REQUEST_BASE
* Descrição: Estrutura base com campos para request de serviço OData
*            de baixa de lubrificante no WM
* Autor: RAC Software
* Data: 2026-05-07
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ZSR_WM_LUBRIFICANTE_REQUEST_BASE,
         LGNUM      TYPE CHAR4,   " Número do depósito
         BWLVS      TYPE CHAR3,   " Chave de armazenamento
         MATNR      TYPE CHAR18,  " Número do material
         WMENG      TYPE QUAN13,  " Quantidade
         MEINS      TYPE UNIT3,   " Unidade de medida
         LTNUM      TYPE CHAR10,  " Número da posição de origem (opcional)
         LTPOS      TYPE CHAR4,   " Item da posição de origem (opcional)
         ETENR      TYPE CHAR10,  " Número da posição de destino (opcional)
         ETEPO      TYPE CHAR4,   " Item da posição de destino (opcional)
         NUMKL      TYPE CHAR10,  " Número do lote (opcional)
       END OF ZSR_WM_LUBRIFICANTE_REQUEST_BASE.