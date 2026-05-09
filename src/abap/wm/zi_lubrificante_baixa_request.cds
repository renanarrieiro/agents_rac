@AbapCatalog.sqlViewName: 'ZI_LUBRIFICANTE_BAIXA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@OData.publish: true

define view entity ZI_LUBrificanteBaixaRequest
  as projection on ZI_LUBrificanteBaixaRequestData {
  // Campos fixos
  @Semantics.key: true
  @UI.lineItem: { position: 10 }
  @UI.identification: [ { position: 10 } ]
  LGNUM,

  // Campos variáveis do CSV
  @UI.lineItem: { position: 20 }
  @UI.identification: [ { position: 20 } ]
  MATNR,

  @UI.lineItem: { position: 30 }
  @UI.identification: [ { position: 30 } ]
  WERKS,

  @UI.lineItem: { position: 40 }
  @UI.identification: [ { position: 40 } ]
  LGORT,

  @UI.lineItem: { position: 50 }
  @UI.identification: [ { position: 50 } ]
  ANFME,

  @UI.lineItem: { position: 60 }
  @UI.identification: [ { position: 60 } ]
  ALTME,

  @UI.lineItem: { position: 70 }
  @UI.identification: [ { position: 70 } ]
  SQUIT,

  @UI.lineItem: { position: 80 }
  @UI.identification: [ { position: 80 } ]
  VLTYP,

  @UI.lineItem: { position: 90 }
  @UI.identification: [ { position: 90 } ]
  VLPLA,

  @UI.lineItem: { position: 100 }
  @UI.identification: [ { position: 100 } ]
  NLTYP,

  @UI.lineItem: { position: 110 }
  @UI.identification: [ { position: 110 } ]
  NLPLA,

  @UI.lineItem: { position: 120 }
  @UI.identification: [ { position: 120 } ]
  BNAME,

  @UI.lineItem: { position: 130 }
  @UI.identification: [ { position: 130 } ]
  KOMPL,

  // Campos fixos para baixa de lubrificante
  @UI.hidden: true
  BWLVS,

  @UI.hidden: true
  VLBER,

  @UI.hidden: true
  NLBER
}