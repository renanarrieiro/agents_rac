@AbapCatalog.sqlViewName: 'ZCLUBRIFBAIXA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lubrificante Baixa - View Entity'
@ObjectModel.usageType.dataClass: #MIXED
@ObjectModel.usageType.createEnabled: true
@ObjectModel.usageType.updateEnabled: true
@ObjectModel.usageType.deleteEnabled: true
@ObjectModel.usageType.key.type: #DEFAULT
@ObjectModel.usageType.association: [1]
@ObjectModel.usageType.association: [2]
@ObjectModel.viewType: #COMPOSITION

define view entity ZC_LUBRIFICANTE_BAIXA_CDS
  as projection on ZI_LUBRIFICANTE_BAIXA
{
  key Client,
  key ZlubrificanteBaixaID,
  
  // Campos de entrada
  @ObjectModel.propertyInfo: { position: 10 }
  I_Matnr,
  
  @ObjectModel.propertyInfo: { position: 20 }
  I_Anfme,
  
  @ObjectModel.propertyInfo: { position: 30 }
  I_Vlpla,
  
  @ObjectModel.propertyInfo: { position: 40 }
  I_Nlpla,
  
  @ObjectModel.propertyInfo: { position: 50 }
  I_Squit,
  
  @ObjectModel.propertyInfo: { position: 60 }
  I_Kompl,
  
  @ObjectModel.propertyInfo: { position: 70 }
  I_Bname,
  
  @ObjectModel.propertyInfo: { position: 80 }
  I_Qname,
  
  // Campos de saída
  @ObjectModel.propertyInfo: { position: 90 }
  E_Tanum,
  
  @ObjectModel.propertyInfo: { position: 100 }
  E_Message,
  
  // Timestamps
  CreatedAt,
  CreatedBy,
  LastChangedAt,
  LastChangedBy,
  LocalLastChangedAt
}