@EndUserText.label: 'SO Item - Consumption'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZClaude_C_SO_Item
  as select from ZClaude_I_SO_Item
{
      @UI.lineItem: [ { position: 10, importance: #HIGH } ]
  key SalesOrder,
      @UI.lineItem: [ { position: 20, importance: #HIGH } ]
  key Item,
      @UI.lineItem: [ { position: 30, importance: #HIGH } ]
      Material,
      @UI.lineItem: [ { position: 40, importance: #HIGH } ]
      Description,
      @UI.lineItem: [ { position: 50 } ]
      Quantity,
      @UI.lineItem: [ { position: 60 } ]
      Unit,
      @UI.lineItem: [ { position: 70 } ]
      NetPrice,
      @UI.lineItem: [ { position: 80 } ]
      NetValue,
      @UI.lineItem: [ { position: 90 } ]
      Plant
}
