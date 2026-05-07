# Mapeamento Detalhado dos Campos JSON para OData V4 - Baixa de Lubrificantes

## Estrutura de Entrada JSON

```json
{
  "matnr": "MAT000123",           // Código do Material (obrigatório)
  "werks": "1000",               // Código do Centro (obrigatório)
  "lgort": "0001",               // Código do Almoxarifado (obrigatório)
  "anfme": "10.5",               // Quantidade (obrigatório)
  "altme": "KG",                 // Unidade de Medida (obrigatório)
  "vpl_a": "0001-001",           // Posição de origem (obrigatório)
  "npl_a": "0002-001",           // Posição de destino (obrigatório)
  "squit": "X",                  // Confirmação Imediata (opcional: '' ou 'X')
  "bname": "JOAO.SILVA",         // Nome do usuário (obrigatório)
  "kompl": ""                    // Remessa Completa (opcional: '' ou 'X')
}
```

## Mapeamento para Tipos ABAP

| Campo JSON | Tipo ABAP | Tabela/Origem | Descrição | Obrigatório |
|------------|-----------|---------------|-----------|-------------|
| `matnr` | `MARA-MATNR` | MARA | Código do Material | Sim |
| `werks` | `T001W-WERKS` | T001W | Código do Centro | Sim |
| `lgort` | `MARD-LGORT` | MARD | Código do Almoxarifado | Sim |
| `anfme` | `MSEG-MENGE` | MSEG | Quantidade | Sim |
| `altme` | `T006-MSEH` | T006 | Unidade de Medida | Sim |
| `vpl_a` | `MARD-LGPLA` | MARD | Posição de origem | Sim |
| `npl_a` | `MARD-LGPLA` | MARD | Posição de destino | Sim |
| `squit` | `CHAR1` | - | Confirmação Imediata | Não |
| `bname` | `SY-UNAME` | - | Nome do usuário | Sim |
| `kompl` | `CHAR1` | - | Remessa Completa | Não |

## Campos Fixos (Internos)

| Campo | Valor | Descrição |
|-------|-------|-----------|
| `lgnum` | 'AR2' | Código do Armazém |
| `bwlvs` | '999' | Tipo de Movimento |
| `vltyp` | 'IN5' | Tipo de Documento Origem |
| `vlber` | '001' | Centro Origem |
| `nltyp` | 'CMA' | Tipo de Documento Destino |
| `nlber` | '001' | Centro Destino |

## Anotações OData para CDS View

```abap
@OData.publish: true
@OData.entityType: true
@OData.entitySet: 'SismaLubrificantesInputSet'
@OData.navigationProperty: {
  name: 'ToMaterial',
  entitySet: 'Mara',
  targetEntity: 'Mara'
}
```

## Validações de Dados

### Campos Obrigatórios
- `matnr`: Deve existir na tabela MARA
- `werks`: Deve existir na tabela T001W
- `lgort`: Deve existir na tabela MARD para o centro informado
- `anfme`: De ser maior que 0
- `altme`: Deve existir na tabela T006
- `vpl_a` e `npl_a`: Formato esperado "XXXX-XXX" (posição-armazém)

### Campos Opcionais
- `squit`: Valores permitidos: '' (vazio) ou 'X'
- `kompl`: Valores permitidos: '' (vazio) ou 'X'

## Integração com Autenticação

O campo `bname` será preenchido automaticamente com o usuário autenticado no serviço OData, conforme sub-task de autenticação.

## Próximos Passos

1. Implementar o serviço OData V4 com base nesta estrutura
2. Adicionar validações de negócio
3. Implementar a lógica de baixa de lubrificantes
4. Criar testes unitários