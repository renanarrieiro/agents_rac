*&---------------------------------------------------------------------*
*& Estrutura de Response para Serviço OData WM Baixa Lubrificante
*&---------------------------------------------------------------------*
*
* Estrutura: ZSR_WM_LUBRIFICANTE_RESPONSE
* Descrição: Mapeia o payload JSON de response para baixa de lubrificante
* Campos: Campos de resposta com número da transferência e mensagens
*&---------------------------------------------------------------------*

TYPES: BEGIN OF zsr_wm_lubrificante_response,
       to_number  TYPE char20,       " Número da Transferência de Ordem gerado
       message    TYPE char255,      " Mensagem de sucesso ou erro
       erro       TYPE char255,      " Campo para mensagem de erro (preencher apenas em caso de erro)
       " Campos adicionais para controle
       success    TYPE abap_bool,    " Indicador de sucesso
       timestamp  TYPE timestampl,   " Timestamp da resposta
       END OF zsr_wm_lubrificante_response.