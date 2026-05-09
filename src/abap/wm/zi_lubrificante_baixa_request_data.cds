@AbapCatalog.sqlViewName: 'ZI_LUBRIF_DATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED

define view entity ZI_LUBrificanteBaixaRequestData
  as select from @AbapCatalog.sqlViewName: 'ZI_LUBRIF_DATA' as data {
  // Campos fixos
  cast( 'AR2' as lgnum ) as LGNUM,
  cast( '999' as bwlvs ) as BWLVS,
  cast( '001' as vlber ) as VLBER,
  cast( '001' as nlber ) as NLBER,

  // Campos variáveis - serão preenchidos dinamicamente
  cast( '' as matnr ) as MATNR,
  cast( '' as werks ) as WERKS,
  cast( '' as lgort ) as LGORT,
  cast( '0' as anfme ) as ANFME,
  cast( '0' as altme ) as ALTME,
  cast( '' as squit ) as SQUIT,
  cast( '' as vltyp ) as VLTYP,
  cast( '' as vlpla ) as VLPLA,
  cast( '' as nltyp ) as NLTYP,
  cast( '' as nlpla ) as NLPLA,
  cast( '' as bname ) as BNAME,
  cast( '' as kompl ) as KOMPL
}