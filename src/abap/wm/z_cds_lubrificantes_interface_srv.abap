@EndUserText.label: 'Serviço OData V4 para Interface de Baixa de Lubrificantes'
@ObjectModel.queryAllowed: true
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: false
@OData.publish: true

define behavior for Z_C_LUBRIFICANTES_INTERFACE
{
  create;
  update;
  delete ( );
  field ( mandatory ) Material, Centro, Almoxarifado, Quantidade, UnidadeMedida, PosicaoOrigem, PosicaoDestino, ConfirmacaoImediata;
  field ( readonly ) DepositoAR2, TipoMovimento, TipoDepositoOrigem, AreaDepositoOrigem, TipoDepositoDestino, AreaDepositoDestino, NumeroTO, Status, Mensagem, DetalhesErro;
}