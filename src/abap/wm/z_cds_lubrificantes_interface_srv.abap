@AbapCatalog.sqlViewName: 'ZCDSLUBRIFSRV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface de Baixa de Lubrificantes - Estrutura de Saída'
@OData.publish: true

define view Z_CDS_Lubrificantes_Interface_Out
  as select from dummy
{
  // Campos de resposta
  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  @Semantics.transactionNumber: true
  @ObjectModel.usageType.serviceUsage: {
    $Type: 'ZCL_LUBRIFICANTES_TYPES=>T_LUBRIFICANTES_RESPONSE'
  }
  Tanum as NumeroTO,

  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  Status,

  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  Mensagem,

  @UI.lineItem: [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  DetalhesErro
}