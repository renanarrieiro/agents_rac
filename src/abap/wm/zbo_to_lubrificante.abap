@EndUserText.label: 'Transfer Order BO for Lubricants'
@ObjectModel: {
  semanticKey: 'TANUM',
  createEnabled: true,
  deleteEnabled: false,
  updateEnabled: false,
  compositionRoot: true
}
@UI: {
  headerInfo: {
    typeName: 'Transfer Order',
    typeNamePlural: 'Transfer Orders',
    creatable: true,
    updatable: false,
    deletable: false
  }
}
@OData.publish: true
@Persistence.skip: true

define behavior for ZBO_TO_LUBRIFICANTE {
  create;
  update;
  delete;
  lock dependent;

  // Root node representing a Transfer Order
  element ZTO_Lubrif {
    // Fixed values for Transfer Order creation
    // I_LGNUM (fixed AR2)
    // I_BWLVS (fixed 999)
    // I_VLTYP (fixed IN5)
    // I_VLBER (fixed 001)
    // I_NLTYP (fixed CMA)
    // I_NLBER (fixed 001)
    
    // Dynamic input fields
    @UI: { lineItem: { position: 10 } }
    @Semantics.material: true
    @ObjectModel.readOnly: false
    MATNR : abap.char(18);
    
    @UI: { lineItem: { position: 20 } }
    @Semantics.unitOfMeasure: true
    @ObjectModel.readOnly: false
    WERKS : abap.char(4);
    
    @UI: { lineItem: { position: 30 } }
    @Semantics.unitOfMeasure: true
    @ObjectModel.readOnly: false
    LGORT : abap.char(4);
    
    @UI: { lineItem: { position: 40 } }
    @Semantics.quantity: true
    @ObjectModel.readOnly: false
    ANFME : abap.decimal(15,3);
    
    @UI: { lineItem: { position: 50 } }
    @Semantics.unitOfMeasure: true
    @ObjectModel.readOnly: false
    ALTME : abap.char(3);
    
    @UI: { lineItem: { position: 60 } }
    @ObjectModel.readOnly: false
    SQUIT : abap.char(1);
    
    @UI: { lineItem: { position: 70 } }
    @ObjectModel.readOnly: false
    VLPLA : abap.char(10);
    
    @UI: { lineItem: { position: 80 } }
    @ObjectModel.readOnly: false
    NLPLA : abap.char(10);
    
    @UI: { lineItem: { position: 90 } }
    @Semantics.user: true
    @ObjectModel.readOnly: false
    BNAME : abap.char(12);
    
    @UI: { lineItem: { position: 100 } }
    @ObjectModel.readOnly: false
    KOMPL : abap.char(1);
    
    // Output fields
    @UI: { lineItem: { position: 110 }, identification: { position: 1 } }
    @Semantics.key: true
    @ObjectModel.readOnly: true
    TANUM : abap.char(10);
    
    @UI: { lineItem: { position: 120 } }
    @Semantics.key: true
    @ObjectModel.readOnly: true
    TAPOS : abap.char(4);
    
    // Fixed values (not exposed to UI)
    @ObjectModel.hidden: true
    LGNUM : abap.char(4) value 'AR2';
    
    @ObjectModel.hidden: true
    BWLVS : abap.char(3) value '999';
    
    @ObjectModel.hidden: true
    VLTYP : abap.char(4) value 'IN5';
    
    @ObjectModel.hidden: true
    VLBER : abap.char(4) value '001';
    
    @ObjectModel.hidden: true
    NLTYP : abap.char(4) value 'CMA';
    
    @ObjectModel.hidden: true
    NLBER : abap.char(4) value '001';
    
    // Action for creating Transfer Order
    action CREATE_TO {
      // Implementation will be handled in behavior definition
    }
    
    // Messages for error handling
    @UI: { lineItem: { position: 130 } }
    @ObjectModel.readOnly: true
    MESSAGE : abap.char(220);
    
    @UI: { lineItem: { position: 140 } }
    @ObjectModel.readOnly: true
    MESSAGE_TYPE : abap.char(1);
  }
}