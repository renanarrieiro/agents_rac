# Instruções para Criação do Projeto SEGW ZWM_LUBRIFICANTE_SRV

## Visão Geral
Este documento descreve os passos para criar um projeto SEGW (Service Builder) para o serviço OData ZWM_LUBRIFICANTE_SRV no SAP S/4HANA.

## Pré-requisitos
- Acesso à transação SEGW
- Permissões para criar objetos de serviço
- Conhecimento básico de OData e ABAP

## Passos de Implementação

### 1. Acessar a Transação SEGW
1. Execute a transação `SEGW` no SAP
2. Clique em "Create New Project"

### 2. Configurar Propriedades Básicas do Projeto
- **Project Name**: `ZWM_LUBRIFICANTE_SRV`
- **Description**: `Serviço OData para gestão de lubrificantes`
- **Namespace**: `ZWM_LUBRIFICANTE` (ou conforme padrão da empresa)
- **Package**: Selecionar o package apropriado

### 3. Definir Namespace
- Namespace deve seguir convenções de nomenclatura da empresa
- Recomendado: `ZWM_LUBRIFICANTE` para manter consistência

### 4. Configurar Propriedades do Serviço
- Service Name: `ZWM_LUBRIFICANTE_SRV`
- Service Version: `0001`
- Service Description: `Serviço OData para gestão de lubrificantes`

### 5. Estrutura do Projeto
O projeto deve conter as seguintes entidades:
- **Data Provider Class (DPC)**: Classe ABAP que implementa a lógica de negócio
- **Media Provider Class (MPC)**: Classe ABAP que define os metadados do serviço
- **Entity Types**: Tipos de dados para as entidades do serviço
- **Entity Sets**: Conjuntos de entidades expostos via OData

### 6. Próximos Passos
1. Criar as entidades necessárias para o serviço
2. Implementar os métodos de CRUD
3. Configurar as associações entre entidades
4. Testar o serviço via OData tester

## Convenções de Nomenclatura
- Classes: `ZCL_WM_LUBRIFICANTE_*`
- Interfaces: `ZIF_WM_LUBRIFICANTE_*`
- Entity Types: `ZWM_LUBRIFICANTE_*`
- Entity Sets: `ZWM_LUBRIFICANTE_*`

## Notas Importantes
- Seguir princípios Clean Core
- Não modificar tabelas padrão do SAP
- Utilizar RAP (Business Object) quando aplicável
- Implementar tratamento de erros robusto