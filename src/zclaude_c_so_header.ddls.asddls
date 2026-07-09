@EndUserText.label: 'SO Header - Consumption'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
@UI.headerInfo: { typeName: 'Sales Order',
                  typeNamePlural: 'Sales Orders',
                  title: { type: #STANDARD, value: 'SalesOrder' } }
define root view entity ZClaude_C_SO_Header
  as select from ZClaude_I_SO_Header
  association [0..*] to ZClaude_C_SO_Item as _Item
    on $projection.SalesOrder = _Item.SalesOrder
{
      @UI.facet: [ { id: 'Header', purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label: 'Order Details', position: 10 },
                   { id: 'Items',  purpose: #STANDARD, type: #LINEITEM_REFERENCE, label: 'Items', position: 20, targetElement: '_Item' } ]
      @UI.lineItem: [ { position: 10, importance: #HIGH } ]
      @UI.identification: [ { position: 10 } ]
      @UI.selectionField: [ { position: 10 } ]
  key SalesOrder,
      @UI.lineItem: [ { position: 20, importance: #HIGH } ]
      @UI.identification: [ { position: 20 } ]
      @UI.selectionField: [ { position: 20 } ]
      Customer,
      @UI.lineItem: [ { position: 30 } ]
      @UI.identification: [ { position: 30 } ]
      OrderType,
      @UI.lineItem: [ { position: 40 } ]
      @UI.identification: [ { position: 40 } ]
      CreatedDate,
      @UI.lineItem: [ { position: 50 } ]
      @UI.identification: [ { position: 50 } ]
      @UI.selectionField: [ { position: 30 } ]
      SalesOrg,
      @UI.lineItem: [ { position: 60, importance: #HIGH } ]
      @UI.identification: [ { position: 60 } ]
      NetValue,
      @UI.lineItem: [ { position: 70 } ]
      @UI.identification: [ { position: 70 } ]
      Currency,
      _Item
}
