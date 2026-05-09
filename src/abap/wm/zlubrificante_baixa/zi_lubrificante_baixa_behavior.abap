@EndUserText.label: 'Lubrificante Baixa - Behavior Definition'
@BehaviorDefinition.definitionKind: #ENTITY
@ObjectModel.usageType.dataClass: #ANALYTICAL
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.createEnabled: true
@ObjectModel.readEnabled: true
@ObjectModel.updateEnabled: false
@ObjectModel.deleteEnabled: false

define behavior for ZC_LUBRIFICANTE_BAIXA_CDS
{
  // Ação customizada de criação
  create;
  
  // Métodos de evento para implementar a lógica
  event create;
  
  // Métodos de validação
  validation on save {
    field Material { validate notInitial; }
    field Quantidade { validate notInitial; }
    field Usuario { validate notInitial; }
  }
  
  // Métodos de implementação
  implementation in class ZCL_LUBRIFICANTE_BAIXA_BEHAVIOR unique;
}