# Instruções para Criação do Projeto SEGW ZWM_LUBRIFICANTE_SRV

## Objetivo
Criar um projeto SEGW (OData Service Builder) para o serviço ZWM_LUBRIFICANTE_SRV.

## Passos de Implementação

### 1. Acessar a Transaction SEGW
- Executar transaction `SEGW` no SAP S/4HANA

### 2. Criar Novo Projeto
- Clicar em "Create New Model"
- Informar nome do modelo: `ZWM_LUBRIFICANTE_SRV`
- Namespace: `/RAC/WM` (namespace padrão para projetos RAC)
- Clicar em "Create"

### 3. Configurar Propriedades do Serviço
- Selecionar o modelo criado
- Acessar propriedades do serviço (Service Properties)
- Configurar:
  - Service Name: `ZWM_LUBRIFICANTE_SRV`
  - Service Version: `0001`
  - Service Description: `Serviço OData para Gestão de Lubrificantes`
  - Namespace: `/RAC/WM`
  - Data Source Type: `Database Table`

### 4. Definir Namespace
- Namespace: `/RAC/WM`
- Este namespace será utilizado para todas as entidades e associações do serviço

### 5. Estrutura Básica
O projeto deve conter a seguinte estrutura básica:
- Service Definition: ZWM_LUBRIFICANTE_SRV
- Data Model: Entidades e associações a serem definidas posteriormente
- Service Implementation: Métodos de implementação a serem criados

### 6. Próximos Passos
Após a criação do projeto, será necessário:
1. Definir as entidades do serviço (ex: ZCL_LUBRIFICANTE, ZCL_LUBRIFICANTE_ITEM)
2. Criar associações entre entidades
3. Implementar os métodos de serviço
4. Gerar o serviço e testar

## Convenções de Nomenclatura
- Entidades: Prefixo `ZCL_`
- Views: Prefixo `ZC_`
- BAdIs: Prefixo `ZCL_BADI_`
- Namespace: `/RAC/WM`