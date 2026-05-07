@AbapCatalog.enhancementCategory: #NOT_NULL
@AbapCatalog.tableCategory: #TRANSPARENT
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sisma Baixa Lubrificantes - Estrutura de Entrada'
@ObjectModel.usageType.dataClass: #MIXED
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: false

define entity zcds_sisma_lubrificantes_input {
  key matnr : mara~matnr; // Código do Material (I_MATNR)
  key werks : t001w~werks; // Código do Centro (I_WERKS)
  key lgort : mard~lgort; // Código do Almoxarifado (I_LGORT)
  anfme   : mseg~menge;   // Quantidade (I_ANFME)
  altme   : t006~mseh;    // Unidade de Medida (I_ALTME)
  vpl_a   : mard~lgpla;   // Posição de origem (I_VLPLA)
  npl_a   : mard~lgpla;   // Posição de destino (I_NLPLA)
  squit   : char1;        // Confirmação Imediata (I_SQUIT) - '' ou 'X'
  bname   : syuname;      // Nome do usuário (I_BNAME)
  kompl   : char1;        // Remessa Completa (I_KOMPL) - '' ou 'X'

  // Campos fixos (não entram no JSON, serão preenchidos internamente)
  @UI.hidden: true
  lgnum : abap.char(3) value 'AR2'; // Código do Armazém
  @UI.hidden: true
  bwlvs : abap.char(3) value '999'; // Tipo de Movimento
  @UI.hidden: true
  vltyp : abap.char(3) value 'IN5'; // Tipo de Documento Origem
  @UI.hidden: true
  vlber : abap.char(3) value '001'; // Centro Origem
  @UI.hidden: true
  nltyp : abap.char(3) value 'CMA'; // Tipo de Documento Destino
  @UI.hidden: true
  nlber : abap.char(3) value '001'; // Centro Destino
}