@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO Item - Interface View'
define view entity ZClaude_I_PO_Item
  as select from zcld_po_itm
{
  key ebeln as PurchaseOrder,
  key ebelp as Item,
      matnr as Material,
      txz01 as Description,
      menge as Quantity,
      meins as Unit,
      netpr as NetPrice,
      netwr as NetValue,
      werks as Plant
}
