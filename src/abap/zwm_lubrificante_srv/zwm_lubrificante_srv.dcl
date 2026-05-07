@EndUserText.label: 'Lubrificante Baixa Service'
define service ZWM_LUBRIFICANTE_SRV {
  expose ZWM_LUBRIFICANTE_BAIXA;
}

@EndUserText.label: 'Lubrificante Baixa Entity'
define entity ZWM_LUBRIFICANTE_BAIXA {
  key Material       : abap.char(18);
      Quantidade     : abap.dec(15,3);
      Centro         : abap.char(4);
      Deposito       : abap.char(4);
      Lote           : abap.char(10);
      DataBaixa      : abap.dats;
      MotivoBaixa    : abap.char(3);
      Responsavel    : abap.char(12);
      TOGerada       : abap.char(10);
      Status         : abap.char(1);
      Mensagem       : abap.char(200);
}