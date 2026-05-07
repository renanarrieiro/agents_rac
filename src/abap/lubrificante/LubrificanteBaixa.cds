@AbapCatalog.enhancementCategory: #NOT_NULL
@AbapCatalog.tableCategory: #TRANSPARENT
@AbapCatalog.deliveryClass: #A
@AbapCatalog.dataMaintenance: #RESTRICTED
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Baixa de Lubrificantes'
@ObjectModel.usageType.dataClass: #MIXED
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.createEnabled: #TRUE
@ObjectModel.usageType.updateEnabled: #TRUE
@ObjectModel.usageType.deleteEnabled: #FALSE
@ObjectModel.representativeKey: 'Material'
@ObjectModel.periodicCommit: #TRUE

define entity zlubrificante_baixa
{
  key client                   : abap.clnt not null;
  key lubrificante_baixa_id    : uuid not null;
  
  // Propriedades de entrada
  material                    : matnr not null;
  quantidade                  : menge_d not null;
  centro                      : werks_d not null;
  deposito                    : lgort not null;
  lote                        : charg not null;
  data_baixa                  : dats not null;
  usuario                     : uname not null;
  
  // Campos adicionais opcionais conforme CPI
  nota_fiscal                 : belnr_d;
  item_nota_fiscal            : gjahr_d;
  posicao_nota_fiscal         : buzei_d;
  motivo_baixa                : bewtp;
  observacoes                 : char255;
  
  // Propriedades de saída
  numero_to                   : ebeln;
  status                      : char20;
  mensagem_erro               : char255;
  data_processamento          : timestampl;
  
  // Auditoria
  created_at                  : timestampl;
  created_by                  : uname;
  last_changed_at             : timestampl;
  last_changed_by             : uname;
  
  // Associações
  association _material       to zmaterial\_material\_text as _material\_text on $projection.material = _material.material;
  association _centro         to zcentro\_cost\_center\_text as _centro\_text on $projection.centro = _centro.centro;
  association _deposito       to zdeposito\_storage\_location\_text as _deposito\_text on $projection.deposito = _deposito.deposito;
  association _lote           to zbatch\_batch\_text as _lote\_text on $projection.lote = _lote.lote;
}