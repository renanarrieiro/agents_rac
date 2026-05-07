@EndUserText.label: 'Behavior Definition Lubrificante Baixa'
@AbapCatalog.enhancementCategory: #NOT_EXTENSIBLE
@AbapCatalog.classKind: #UNIQUE
@AbapCatalog.tableCategory: #TRANSPARENT
@AbapCatalog.dataMaintenance: #RESTRICTED

define behavior for ZLUBRIFICANTE_BAIXA
{
  create;
  update;
  delete;
  lock dependent by BaixaID;
    
  mapping for ZLUBRIFICANTE_BAIXA
    {
      BaixaID      = BaixaID;
      Material     = Material;
      Centro       = Centro;
      Deposito     = Deposito;
      Quantidade   = Quantidade;
      Unidade      = Unidade;
      PosicaoOrigem = PosicaoOrigem;
      PosicaoDestino = PosicaoDestino;
      TipoMovimento = TipoMovimento;
      Motivo       = Motivo;
      DataMovimento = DataMovimento;
      HoraMovimento = HoraMovimento;
      Status       = Status;
      Mensagem     = Mensagem;
      NumeroDocumento = NumeroDocumento;
    }
    
  // Custom action para baixa de lubrificantes
  action (features: #FOR_UPDATE) BaixaLubrificante
    {
      parameter $request : ZLUBRIFICANTE_BAIXA;
      result result : ZLUBRIFICANTE_BAIXA;
    }
    
  // Event handlers
  event created on instance of ZLUBRIFICANTE_BAIXA
  {
    do = raise event BaixaCriada;
  }
    
  event BaixaCriada
  {
    do = raise event ProcessarBaixa;
  }
    
  event ProcessarBaixa
  {
    do = raise event ValidarBaixa;
  }
    
  event ValidarBaixa
  {
    do = raise event ExecutarBaixa;
  }
    
  event ExecutarBaixa
  {
    do = raise event AtualizarStatus;
  }
    
  event AtualizarStatus
  {
    do = raise event EnviarResposta;
  }
    
  event EnviarResposta
  {
    do = raise event BaixaFinalizada;
  }
    
  event BaixaFinalizada
  {
    do = raise event BaixaCriada;
  }
}