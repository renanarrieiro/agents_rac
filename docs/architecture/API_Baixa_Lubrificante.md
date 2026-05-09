# Arquitetura Técnica e Análise de Lacunas - API OData V4 para Baixa de Lubrificante

## Visão Geral da Solução
Criar uma API OData V4 exposta no SAP S/4HANA (usando o modelo ABAP RESTful Application Programming Model - RAP) que será consumida pelo SAP CPI, que por sua vez recebe chamadas do sistema terceiro SISMA. A API será responsável por criar uma Ordem de Transferência (OT) no módulo WM utilizando as funções de função L_TO_CREATE_SINGLE e, se necessário, L_TO_CONFIRM, e retornar o número da OT gerada.

## Decisões de Arquitetura
- **Modelo de Programação**: ABAP RAP (Behavioral PO) para garantir aderência ao Clean Core e facilitar a exposição automática de serviços OData V2/V4.
- **Entidade RAP**: `ZLUBRIFICANTE_BAIXA` (não persistente, apenas para processamento) com ação de criação (`create`) que recebe os parâmetros de entrada e executa a lógica de criação e confirmação da OT.
- **Serviço OData V4**: Definido através de serviço de ligação (service binding) exposto no grupo de serviços padrão `/sap/opu/odata4/` com nome customizado `ZLUBRIFICANTE_BAIXA_SRV`.
- **Tratamento de Erros**: Utilizar exceções levantadas pelas FMs e mapear para respostas OData com códigos de erro apropriados (ex: 400 Bad Request, 500 Internal Server Error). Log de erros via Application Log (SLG1) quando relevante.
- **Log de Processo**: Registrar na Application Log (objeto ZLUBRIFICANTE_BAIXA) os principais passos: início, chamadas às FMs, número da OT gerada, e eventuais exceções.
- **Autenticação/Autorização**: O serviço será protegido pelo mecanismo de autenticação padrão do SAP Gateway (ex: usuário técnico ou OAuth2 via SAP CPI). Autorizações serão verificadas através do objeto de autorização S_WDYNB (para serviços OData) e, se necessário, autorização específica do WM (como S_WDYN?).
- **Transacionalidade**: As chamadas às FMs serão feitas dentro de uma única LUW (Logical Unit of Work) via comportamento RAP (transacional automático). Se a confirmação for feita em etapa separada, ainda assim será mantida dentro da mesma transação via chamada sequencial.

## Mapeamento de Dados de Entrada (exemplo)
| Campo EF          | Tipo        | Comentário / Valor Fixo                     | Variável? |
|-------------------|-------------|---------------------------------------------|-----------|
| I_LGNUM           | CHAR(4)     | Depósito - Fixar AR2                        | Não       |
| I_BWLVS           | CHAR(3)     | Tipo de Movimento - Fixar 999               | Não       |
| I_MATNR           | CHAR(18)    | Código de Material                          | Sim       |
| I_WERKS           | CHAR(4)     | Planta - Fixar AR20                         | Não       |
| I_LGORT           | CHAR(4)     | Código do Almoxarifado - Fixar ALM2         | Não       |
| I_ANFME           | QUAN        | Quantidade                                  | Sim       |
| I_ALTME           | UNIT        | Unidade de Medida - Fixar M                 | Não       |
| I_SQUIT           | CHAR(1)     | Confirmação Imediata - 'X' se confirmar na criação | Sim (opcional) |
| I_VLTYP           | CHAR(3)     | Tipo de depósito Origem - Fixar IN5         | Não       |
| I_VLBER           | CHAR(4)     | Área do Depósito Origem - Fixar 001         | Não       |
| I_VLPLA           | CHAR(10)    | Posição de origem (ex: C-01-02)             | Sim       |
| I_NLTYP           | CHAR(3)     | Tipo de depósito Destino - Fixar CMA        | Não       |
| I_NLBER           | CHAR(4)     | Área do Depósito Destino - Fixar 001        | Não       |
| I_NLPLA           | CHAR(10)    | Posição de Destino (ex: Z-202)              | Sim       |
| I_BNAME           | CHAR(12)    | Nome do usuário (para L_TO_CREATE_SINGLE)   | Sim (usuário técnico ou passado no header) |
| I_KOMPL           | CHAR(1)     | Remessa Completa - 'X' se somente remessa completa | Sim (opcional) |
| I_QNAME           | CHAR(12)    | Nome do usuário (para L_TO_CONFIRM)         | Sim (mesmo que I_BNAME ou usuário ativo) |

> **Nota**: Os campos marcados como "Fixar" serão constantes no código. Os campos variáveis serão recebidos no payload OData.

## Análise de Lacunas / Perguntas Aberta
1. **Autenticação**: Qual mecanismo de autenticação será usado entre CPI e SAP Gateway? (ex: certificado cliente, OAuth2, usuário/senha). Precisamos definir se haverá um usuário técnico específico para chamar a API.
2. **Tratamento de Usuário**: Os campos I_BNAME e I_QNAME devem ser preenchidos com o usuário técnico que está fazendo a chamada ou com o usuário passado no header? Definir se haverá mapeamento de usuário do CPI para usuário SAP.
3. **Confirmação Imediata**: O parâmetro I_SQUIT deve ser sempre 'X' (OT nasce confirmada) ou pode ser controlado pelo payload? A EF indica que se marcado com X a OT nasce confirmada. Precisamos saber se o SISMA enviará esse flag.
4. **Remessa Completa (I_KOMPL)**: Similar ao item 3, definir se será fixo ou variável.
5. **Validação de Dados de Entrada**: Quais validações adicionais (ex: existência do material na planta, existência dos bins de origem/destino) devem ser feitas antes de chamar as FMs? As FMs já retornam erro, mas talvez queiramos validar antecipadamente e retornar mensagem mais amigável.
6. **Log de Erros**: Além do Application Log, deveremos retornar mensagens de erro detalhadas no corpo da resposta OData? Definir formato (ex: mensagem simples ou estrutura de erro OData V4).
7. **Resposta de Sucesso**: Além do número da OT, deveremos retornar outros dados (ex: data de confirmação, quantidade confirmada)? A EF indica retornar apenas o número da OT.
8. **Tratamento de Duplicidade**: Há risco de criação de OT duplicada se o mesmo pedido for enviado duas vezes? Deveríamos verificar alguma condição de idempotência (ex: número de lote ou referência externa)?
9. **Performance**: Volume esperado de chamadas? Necessidade de paginação ou processamento em lote? Provavelmente baixa volumetria, mas validar.
10. **Transportes**: Quais objetos serão criados e precisam ser transportados? Listar no plano de transporte.

## Próximos Passos
- Definir as respostas às lacunas acima com o cliente/functional stakeholder.
- Após esclarecimentos, o desenvolvedor ABAP sênior implementará a solução seguindo as tarefas técnicas detalhadas abaixo.
