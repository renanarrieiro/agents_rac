*&---------------------------------------------------------------------*
*& Estrutura de Request para Serviço OData WM Baixa Lubrificante
*&---------------------------------------------------------------------*
*
* Estrutura: ZSR_WM_LUBRIFICANTE_REQUEST
* Descrição: Mapeia o payload JSON de request para baixa de lubrificante
* Campos: Campos necessários para L_TO_CREATE_SINGLE
*&---------------------------------------------------------------------*

TYPES: BEGIN OF zsr_wm_lubrificante_request,
       lgnum      TYPE char4,        " Número do depósito
       bwlvs      TYPE char3,        " Chave de armazenamento
       matnr      TYPE char18,       " Número do material
       wmeng      TYPE quan13,       " Quantidade
       meins      TYPE unit3,        " Unidade de medida
       ltnum      TYPE char10,       " Número da posição de origem (opcional)
       ltpos      TYPE char4,        " Item da posição de origem (opcional)
       etenr      TYPE char10,       " Número da posição de destino (opcional)
       etepo      TYPE char4,        " Item da posição de destino (opcional)
       numkl      TYPE char10,       " Número do lote (opcional)
       " Campos adicionais conforme necessário para L_TO_CREATE_SINGLE
       lgort      TYPE lgort,        " Local de armazenamento
       werks      TYPE werks_d,      " Centro
       charg      TYPE charg,        " Número do lote (alternativo)
       sobkz      TYPE sobkz,        " Indicador especial de estoque
       bstme      TYPE bstme,        " Unidade de medida básica
       END OF zsr_wm_lubrificante_request.