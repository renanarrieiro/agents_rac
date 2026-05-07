@EndUserText.label: 'Tipos para Interface de Baixa de Lubrificantes'
@AbapCatalog.enhancementCategory: #NOT_ALLOWED
@AbapCatalog.classKind: #INTF
@AbapCatalog.tableCategory: #TRANSP
@AbapCatalog.dataMaintenance: #ALLOWED
@AbapCatalog.classType: #INTF

public interface ZCL_LUBRIFICANTES_TYPES
  public section.

  types:
    begin of T_LUBRIFICANTES_INPUT,
      Material type MATNR,
      Centro type WERKS,
      Almoxarifado type LGORT,
      Quantidade type MENGE_D,
      UnidadeMedida type MEINS,
      PosicaoOrigem type LGPBE,
      PosicaoDestino type LGPBE,
      FlagConfirmacaoImediata type CHAR1,
      DepositoOrigem type LGORT,
      TipoMovimento type BWART,
      TipoDepositoOrigem type XCHPF,
      AreaDepositoOrigem type XCHPF,
      TipoDepositoDestino type XCHPF,
      AreaDepositoDestino type XCHPF,
    end of T_LUBRIFICANTES_INPUT,

    begin of T_LUBRIFICANTES_RESPONSE,
      NumeroTO type EBELN,
      Status type CHAR1,
      Mensagem type CHAR100,
      DetalhesErro type CHAR255,
    end of T_LUBRIFICANTES_RESPONSE.

endinterface.