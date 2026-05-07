@AbapCatalog.sqlViewName: 'ZCDSLUBRIFACE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@OData.publish: true

define view Z_CDS_LUBRIFICANTES_INTERFACE
  as select from dummy
{
  -- Campos de entrada (Input)
  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  @Semantics.material: true
  @EndUserText.label: 'Material'
  material as Material,

  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  @Semantics.businessArea: true
  @EndUserText.label: 'Centro'
  werks as Centro,

  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  @EndUserText.label: 'Almoxarifado'
  lgort as Almoxarifado,

  @UI.lineItem: [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  @Semantics.quantity.unitOfMeasure: 'UNIDADE_MEDIDA'
  @EndUserText.label: 'Quantidade'
  menge as Quantidade,

  @UI.lineItem: [{ position: 50 }]
  @UI.identification: [{ position: 50 }]
  @Semantics.unitOfMeasure: true
  @EndUserText.label: 'Unidade de Medida'
  meins as UnidadeMedida,

  @UI.lineItem: [{ position: 60 }]
  @UI.identification: [{ position: 60 }]
  @EndUserText.label: 'Posição de Origem'
  lgort_orig as PosicaoOrigem,

  @UI.lineItem: [{ position: 70 }]
  @UI.identification: [{ position: 70 }]
  @EndUserText.label: 'Posição de Destino'
  lgort_dest as PosicaoDestino,

  @UI.lineItem: [{ position: 80 }]
  @UI.identification: [{ position: 80 }]
  @EndUserText.label: 'Confirmação Imediata'
  conf_imediata as ConfirmacaoImediata,

  -- Campos fixos internos
  @UI.hidden: true
  @EndUserText.label: 'Depósito AR2'
  dep_ar2 as DepositoAR2,

  @UI.hidden: true
  @EndUserText.label: 'Tipo de Movimento 999'
  tipo_movimento as TipoMovimento,

  @UI.hidden: true
  @EndUserText.label: 'Tipo Depósito Origem IN5'
  tipo_dep_orig as TipoDepositoOrigem,

  @UI.hidden: true
  @EndUserText.label: 'Área Depósito Origem 001'
  area_dep_orig as AreaDepositoOrigem,

  @UI.hidden: true
  @EndUserText.label: 'Tipo Depósito Destino CMA'
  tipo_dep_dest as TipoDepositoDestino,

  @UI.hidden: true
  @EndUserText.label: 'Área Depósito Destino 001'
  area_dep_dest as AreaDepositoDestino,

  -- Campos de saída (Response)
  @UI.lineItem: [{ position: 90 }]
  @UI.identification: [{ position: 90 }]
  @EndUserText.label: 'Número da TO'
  tanum as NumeroTO,

  @UI.lineItem: [{ position: 100 }]
  @UI.identification: [{ position: 100 }]
  @EndUserText.label: 'Status'
  status as Status,

  @UI.lineItem: [{ position: 110 }]
  @UI.identification: [{ position: 110 }]
  @EndUserText.label: 'Mensagem'
  message as Mensagem,

  @UI.lineItem: [{ position: 120 }]
  @UI.identification: [{ position: 120 }]
  @EndUserText.label: 'Detalhes de Erro'
  error_details as DetalhesErro
}