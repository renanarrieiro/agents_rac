*&---------------------------------------------------------------------*
*&  Definição de Payload JSON para API de Baixa Lubrificante
*&  Projeto: WM:Sisma Baixa Lubrificantes
*&  Autor: Senior ABAP Developer
*&  Data: 2025-06-17
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&  Estrutura do Payload JSON para API de Baixa Lubrificante
*&---------------------------------------------------------------------*
*&  Campos obrigatórios (obrigatórios no request):
*&  - I_MATNR  : Código do material (CHAR18)
*&  - I_WERKS  : Código do centro (CHAR4)
*&  - I_LGORT  : Código do almoxarifado (CHAR4)
*&  - I_ANFME  : Quantidade a ser baixada (DEC15,3)
*&  - I_ALTME  : Unidade de medida (CHAR3)
*&
*&  Campos opcionais (podem vir no request):
*&  - I_SQUIT  : Confirmação imediata (CHAR1, 'X' = sim, '' = não)
*&  - I_KOMPL  : Remessa completa (CHAR1, 'X' = sim, '' = não)
*&
*&  Campos com valores fixos (não vem do request):
*&  - I_LGNUM  : Número do depósito = 'AR2'
*&  - I_BWLVS  : Tipo de movimento = '999'
*&  - I_VLTYP  : Tipo de documento = 'IN5'
*&  - I_VLBER  : Local do documento = '001'
*&  - I_NLTYP  : Tipo de nota fiscal = 'CMA'
*&  - I_NLBER  : Local da nota fiscal = '001'
*&
*&---------------------------------------------------------------------*
*&  Mapeamento para Funções L_TO_CREATE_SINGLE e L_TO_CONFIRM
*&---------------------------------------------------------------------*
*&  Campos mapeados para L_TO_CREATE_SINGLE:
*&  - I_MATNR  → MATERIAL
*&  - I_WERKS  → WERKS
*&  - I_LGORT  → LGORT
*&  - I_LGNUM  → LGNUM (fixo)
*&  - I_BWLVS  → BWLVS (fixo)
*&  - I_ANFME  → ANFME
*&  - I_ALTME  → ALTME
*&  - I_VLTYP  → VLTYP (fixo)
*&  - I_VLBER  → VLBER (fixo)
*&  - I_NLTYP  → NLTYP (fixo)
*&  - I_NLBER  → NLBER (fixo)
*&  - I_SQUIT  → SQUIT (opcional)
*&  - I_KOMPL  → KOMPL (opcional)
*&
*&  Campos mapeados para L_TO_CONFIRM:
*&  - I_MATNR  → MATERIAL
*&  - I_WERKS  → WERKS
*&  - I_LGORT  → LGORT
*&  - I_LGNUM  → LGNUM (fixo)
*&  - I_BWLVS  → BWLVS (fixo)
*&  - I_ANFME  → ANFME
*&  - I_ALTME  → ALTME
*&  - I_VLTYP  → VLTYP (fixo)
*&  - I_VLBER  → VLBER (fixo)
*&  - I_NLTYP  → NLTYP (fixo)
*&  - I_NLBER  → NLBER (fixo)
*&  - I_SQUIT  → SQUIT (opcional)
*&  - I_KOMPL  → KOMPL (opcional)
*&
*&---------------------------------------------------------------------*
*&  Tratamento de Campos Ausentes
*&---------------------------------------------------------------------*
*&  Campos obrigatórios ausentes → Retornar erro 400 com mensagem específica
*&  Campos opcionais ausentes → Usar valores padrão:
*&    - I_SQUIT: '' (não confirmar imediatamente)
*&    - I_KOMPL: '' (não é remessa completa)
*&
*&---------------------------------------------------------------------*
*&  Exemplo de Payload JSON
*&---------------------------------------------------------------------*
*&  Request válido:
*&  {
*&    "I_MATNR": "LUBR-001",
*&    "I_WERKS": "1000",
*&    "I_LGORT": "A001",
*&    "I_ANFME": "10.500",
*&    "I_ALTME": "L",
*&    "I_SQUIT": "X",
*&    "I_KOMPL": ""
*&  }
*&
*&  Response sucesso:
*&  {
*&    "success": true,
*&    "message": "Baixa de lubrificante processada com sucesso",
*&    "to_number": "9000001234",
*&    "confirmation_number": "9000001235"
*&  }
*&
*&  Response erro (campo obrigatório ausente):
*&  {
*&    "success": false,
*&    "error": "400",
*&    "message": "Campo obrigatório ausente: I_MATNR"
*&  }
*&
*&---------------------------------------------------------------------*
*&  Validações Adicionais
*&---------------------------------------------------------------------*
*&  - I_MATNR: Deve existir em MARA
*&  - I_WERKS: Deve existir em T001W
*&  - I_LGORT: Deve existir em MARD para o centro e material
*&  - I_ANFME: Deve ser maior que 0
*&  - I_ALTME: Deve existir em MARM
*&
*&---------------------------------------------------------------------*