@AbapCatalog.sqlViewName: 'ZCLUBRIFBAIXAC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lubrificante Baixa - CDS View'
@ObjectModel.usageType.dataClass: #ANALYTICAL
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.createEnabled: true
@ObjectModel.readEnabled: true
@ObjectModel.updateEnabled: false
@ObjectModel.deleteEnabled: false

define view entity ZC_LUBRIFICANTE_BAIXA_CDS
  as select from @AbapCatalog.systemField: { client }
{
  // Campos de entrada
  key I_MATNR    as Material,
      I_ANFME    as Quantidade,
      I_VLPLA    as ValorPlanejado,
      I_NLPLA    as NúmeroLote,
      I_SQUIT    as Sequencia,
      I_KOMPL    as Complemento,
      I_BNAME    as Usuario,
      I_QNAME    as NomeUsuario,
      
  // Campos de saída
      E_TANUM    as NumeroOT,
      E_MESSAGE  as Mensagem
}
