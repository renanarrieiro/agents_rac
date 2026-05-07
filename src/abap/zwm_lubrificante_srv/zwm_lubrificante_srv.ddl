@AbapCatalog.sqlViewName: 'ZWM_LUBRIFBAIXA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lubrificante Baixa'
@Semantics.language: 'E'
@Semantics.quantity.unit: 'ERFME'
@Semantics.quantity: true
define view zwm_lubrificante_baixa as select from mara
  inner join mseg on mseg.matnr = mara.matnr
  inner join mard on mard.matnr = mara.matnr
  inner join mkpf on mkpf.mblnr = mseg.mblnr and mkpf.mjahr = mseg.mjahr
{
  key mara.matnr as Matnr,
  mseg.werks as Werks,
  mard.lgort as LGORT,
  mseg.charg as CHARG,
  mseg.menge as MENGE,
  mseg.erfmg as ERFMG,
  mseg.erfme as ERFME,
  mseg.lgnum as LGNUM,
  mseg.lgtyp as LGTYP,
  mkpf.ebeln as TO_NUMBER,
  'A' as STATUS,
  '' as MESSAGE
}