*&---------------------------------------------------------------------*
*& Estrutura Base para Response de Serviço OData WM Baixa Lubrificante
*&---------------------------------------------------------------------*
*
* Estrutura: ZSR_WM_LUBRIFICANTE_RESPONSE_BASE
* Descrição: Estrutura base com campos para response de serviço OData
*            de baixa de lubrificante no WM
* Autor: RAC Software
* Data: 2026-05-07
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ZSR_WM_LUBRIFICANTE_RESPONSE_BASE,
         TO_NUMBER  TYPE CHAR20,  " Número da Transferência de Ordem gerado
         MESSAGE    TYPE CHAR255, " Mensagem de sucesso ou erro
         ERRO       TYPE CHAR255, " Campo para mensagem de erro (preencher apenas em caso de erro)
       END OF ZSR_WM_LUBRIFICANTE_RESPONSE_BASE.