namespace zwm_lubrificante_srv.

entity LubrificanteBaixa {
  key Matnr : abap.char(18);
  Werks   : abap.char(4);
  LGORT   : abap.char(4);
  CHARG   : abap.char(10);
  MENGE   : abap.decimal(15,3);
  ERFMG   : abap.decimal(15,3);
  ERFME   : abap.char(3);
  LGNUM   : abap.char(4);
  LGTYP   : abap.char(3);
  LGNUM   : abap.char(4);
  LGTYP   : abap.char(3);
  TO_NUMBER : abap.char(12);
  STATUS  : abap.char(4);
  MESSAGE : abap.char(200);
}