@EndUserText.label: 'Lubrificante Baixa'
@AbapCatalog.enhancementCategory: #NOT_EXTENSIBLE
@AbapCatalog.tableCategory: #TRANSPARENT
@AbapCatalog.deliveryClass: #A
@AbapCatalog.dataMaintenance: #RESTRICTED
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.serviceUsage
@ObjectModel.usageType.dataMaintenance
@ObjectModel.representativeKey: 'BaixaID'
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: false
@ObjectModel.deleteEnabled: false
@ObjectModel.readEnabled: true
@ObjectModel.serviceQuality: #A
@ObjectModel.lastChangedAt: true
@ObjectModel.lastChangedBy: true
@ObjectModel.createdBy: true
@ObjectModel.createdAt: true

define entity ZLUBRIFICANTE_BAIXA
{
    key BaixaID      : abap.char(36);
    Material        : abap.char(18);
    Centro          : abap.char(4);
    Deposito        : abap.char(4);
    Quantidade      : abap.dec(15,3);
    Unidade         : abap.char(3);
    PosicaoOrigem   : abap.char(10);
    PosicaoDestino  : abap.char(10);
    TipoMovimento   : abap.char(3);
    Motivo          : abap.char(3);
    DataMovimento   : abap.datn;
    HoraMovimento   : abap.timn;
    Status          : abap.char(1);
    Mensagem        : abap.char(100);
    NumeroDocumento : abap.char(10);
    CreatedAt       : abap.utclong;
    CreatedBy       : abap.char(12);
    LastChangedAt   : abap.utclong;
    LastChangedBy   : abap.char(12);
}