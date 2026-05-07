@AbapCatalog.sqlViewName: 'ZCDSLUBRIFINT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface de Baixa de Lubrificantes - Estrutura de Entrada'
@OData.publish: true

define view Z_CDS_Lubrificantes_Interface_In
  as select from dummy
{
  // Campos variáveis recebidos do SISMA
  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  @Semantics.material: true
  @ObjectModel.usageType.serviceUsage: {
    $Type: 'ZCL_LUBRIFICANTES_TYPES=>T_LUBRIFICANTES_INPUT'
  }
  Material,

  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  @Semantics.businessArea: true
  Centro,

  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  @Semantics.storageLocation: true
  Almoxarifado,

  @UI.lineItem: [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  @Semantics.quantity.unit: 'UnidadeMedida'
  Quantidade,

  @UI.lineItem: [{ position: 50 }]
  @UI.identification: [{ position: 50 }]
  UnidadeMedida,

  @UI.lineItem: [{ position: 60 }]
  @UI.identification: [{ position: 60 }]
  @Semantics.storageLocation: true
  PosicaoOrigem,

  @UI.lineItem: [{ position: 70 }]
  @UI.identification: [{ position: 70 }]
  @Semantics.storageLocation: true
  PosicaoDestino,

  @UI.lineItem: [{ position: 80 }]
  @UI.identification: [{ position: 80 }]
  FlagConfirmacaoImediata,

  // Campos fixos preenchidos internamente
  @UI.hidden: true
  DepositoAR2 as DepositoOrigem,

  @UI.hidden: true
  TipoMovimento999 as TipoMovimento,

  @UI.hidden: true
  TipoDepositoIN5 as TipoDepositoOrigem,

  @UI.hidden: true
  AreaDeposito001 as AreaDepositoOrigem,

  @UI.hidden: true
  TipoDepositoCMA as TipoDepositoDestino,

  @UI.hidden: true
  AreaDeposito001Dest as AreaDepositoDestino
}