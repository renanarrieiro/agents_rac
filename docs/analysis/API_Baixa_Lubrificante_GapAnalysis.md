# Análise de Lacunas e Arquitetura Técnica - API OData V4 Baixa de Lubrificante

## Visão Geral da Solução
A solução consiste em expor um serviço OData V4 que será consumido pelo CPI, que por sua vez receberá chamadas do sistema SISMA. O serviço OData V4 será baseado em um modelo RAP (RESTful Application Programming) para o objeto de negócio ZLUBRIFICANTE_BAIXA. O fluxo será:
1. O CPI envia uma requisição POST para o endpoint OData V4 com os parâmetros necessários para criação da Transferência de Ordem (TO).
2. O serviço OData V4 chama o módulo de função L_TO_CREATE_SINGLE para criar a TO.
3. Se a criação for bem-sucedida e o parâmetro I_SQUIT não estiver definido (ou se o cliente solicitar confirmação separada), o serviço chama L_TO_CONFIRM para confirmar a TO.
4. O serviço retorna o número da TO (LTAP-TANUM) e, opcionalmente, o status de confirmação.
5. Tratamento de erros: exceções dos módulos de função são capturadas e retornadas como respostas OData V4 com códigos de erro apropriados (ex: 400 para erros de negócio, 500 para falhas de sistema).
6. Log de auditoria: opcionalmente, gravação em tabela customizada ZLUBRIFICANTE_BAIXA_LOG para rastrear requisições e respostas.

## Decisões de Arquitetura
- **Modelo RAP**: Utilizado para garantir aderência ao Clean Core, com comportamento definido em classe de comportamento e serviço OData V4 gerado automaticamente.
- **OData V4**: Escolhido por ser o padrão moderno e recomendado para novas exposições de serviços no S/4HANA.
- **Módulos de Função**: L_TO_CREATE_SINGLE e L_TO_CONFIRM são mantidos como está, encapsulados pela lógica do RAP BO.
- **Tratamento de Erros**: Utilização de exceções levantadas pelo RAP BO (mensagens de aplicação) que serão mapeadas para respostas OData com códigos HTTP 400/500.
- **Autenticação/Autorização**: O serviço OData V4 herda as configurações de autenticação do sistema S/4HANA (ex: OAuth2, SAML, ou certificado) configuradas no ICF; não é necessário implementar custommente.
- **Log**: Tabela customizada ZLUBRIFICANTE_BAIXA_LOG (campos: REQUEST_ID, TIMESTAMP, INPUT_PARAMETERS, TO_NUMBER, RETURN_CODE, MESSAGE, CREATED_BY).

## Lacunas / Perguntas Identificadas na ESPECIFICAÇÃO FUNCIONAL
- **Mapeamento de CSV**: A seção "Requisitos da interface" menciona "Mapeamento de arquivos CSV" e "Arquivo de exemplo", mas não foram fornecidos no documento. Necessário esclarecer se a API OData V4 receberá dados diretamente (JSON) ou se haverá pré-processamento de CSV no CPI. Se for o último, o mapeamento CSV não impacta o desenvolvimento ABAP, mas deve ser confirmado.
- **Autenticação e Autorização**: Não especificado como o CPI se autenticará no OData V4 (ex: OAuth2 client-credentials, certificado). Necessário definir o método de autenticação esperado.
- **Tratamento de Campos Opcionais**: Alguns campos da FM têm valores fixos (ex: I_LGNUM=AR2, I_BWLVS=999, I_VLTYP=IN5, I_VLBER=001, I_NLBER=001). Outros são fornecidos pelo cliente (I_MATNR, I_WERKS, I_LGORT, I_ANFME, I_ALTME, I_VLPLA, I_NLPLA, I_BNAME, I_SQUIT, I_KOMPL). Necessário confirmar quais campos são obrigatórios vs opcionais e quais valores fixos devem ser hardcoded.
- **Campo I_BNAME e I_QNAME**: Especificado como "Nome do usuário" e "Usuário ativo". Deve-se usar o usuário logado no serviço OData (sy-uname) ou permitir que o cliente informe? Necessário esclarecer.
- **Tratamento de I_SQUIT e I_KOMPL**: A especificação indica que se I_SQUIT for marcado com X, a TO nasce confirmada. I_KOMPL indica se somente remessas completas. Necessário definir lógica: se I_SQUIT = 'X', não chamar L_TO_CONFIRM; caso contrário, chamar. I_KOMPL deve ser passado tal qual para a FM.
- **Retorno Esperado além do Número da TO**: A especificação menciona retornar o número da TO (ex: 000000155). Deve-se retornar também mensagem de sucesso, e em caso de erro, mensagens descritivas. Definir estrutura de resposta OData (ex: campo TO_NUMBER, MESSAGE, STATUS).
- **Tratamento de Erros de Negócio**: Falta de estoque, divergência de posições. Essas são exceções levantadas pelas FMs. Necessário garantir que sejam capturadas e retornadas com código HTTP 400 (Bad Request) e mensagem legível.
- **Reprocessamento**: Especificado que não há reprocessamento. Não é necessário implementar lógica de repetição ou idempotência além do padrão do OData (que pode ser não idempotente para POST). Porém, considerar se o número da TO deve ser retornado mesmo em caso de falha? Não, apenas em sucesso.
- **Limites de Tamanho e Tipo de Dados**: Não especificado tamanhos máximos para campos como MATERIAL (MATNR), CENTRO (WERKS), etc. Assumir os padrões do DDIC (MATNR 40 chars, WERKS 4 chars, etc.). Confirmar se há necessidade de validação adicional.
- **Segurança (Autorização)**: Quem pode chamar este serviço? Talvez apenas usuários de integração (CPI) com um papel específico. Necessário definir objeto de autorização ou verificar se o padrão S_BC_E já é suficiente.
- **Testes Unitários**: Não especificado quais casos de teste unitário devem ser implementados além dos mencionados na seção de casos de teste (que também não foram detalhados no PDF). Necessário obter os casos de teste detalhados para garantir cobertura.

## Próximos Passos
1. Obter esclarecimentos das lacunas acima com o stakeholder (Manager ou cliente funcional).
2. Após esclarecimentos, refinar o modelo RAP BO e o serviço OData V4.
3. Implementar o desenvolvimento conforme as subtasks técnicas criadas.
4. Realizar testes unitários e de integração.
5. Preparar documentação de operação e guia de consumo para o CPI.
