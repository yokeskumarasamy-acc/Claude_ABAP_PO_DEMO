@EndUserText.label: 'PO Header - Consumption'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
@UI.headerInfo: { typeName: 'Purchase Order',
                  typeNamePlural: 'Purchase Orders',
                  title: { type: #STANDARD, value: 'PurchaseOrder' } }
define root view entity ZClaude_C_PO_Header
  as select from ZClaude_I_PO_Header
  association [0..*] to ZClaude_C_PO_Item as _Item
    on $projection.PurchaseOrder = _Item.PurchaseOrder
{
      @UI.facet: [ { id: 'Header', purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label: 'PO Details', position: 10 },
                   { id: 'Items',  purpose: #STANDARD, type: #LINEITEM_REFERENCE, label: 'Items', position: 20, targetElement: '_Item' } ]
      @UI.lineItem: [ { position: 10, importance: #HIGH } ]
      @UI.identification: [ { position: 10 } ]
      @UI.selectionField: [ { position: 10 } ]
  key PurchaseOrder,
      @UI.lineItem: [ { position: 20, importance: #HIGH } ]
      @UI.identification: [ { position: 20 } ]
      @UI.selectionField: [ { position: 20 } ]
      CompanyCode,
      @UI.lineItem: [ { position: 30 } ]
      @UI.identification: [ { position: 30 } ]
      DocumentType,
      @UI.lineItem: [ { position: 40, importance: #HIGH } ]
      @UI.identification: [ { position: 40 } ]
      Supplier,
      @UI.lineItem: [ { position: 50 } ]
      @UI.identification: [ { position: 50 } ]
      DocumentDate,
      @UI.identification: [ { position: 60 } ]
      PurchOrg,
      @UI.identification: [ { position: 70 } ]
      PurchGroup,
      @UI.lineItem: [ { position: 60 } ]
      @UI.identification: [ { position: 80 } ]
      Currency,
      _Item
}
