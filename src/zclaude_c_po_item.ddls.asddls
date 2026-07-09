@EndUserText.label: 'Projection View: PO Item'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZClaude_C_PO_Item
  provider contract transactional_query
  as projection on ZClaude_I_PO_Item
{
  key Ebeln,
  key Ebelp,
      Matnr,
      Txz01,
      Menge,
      Meins,
      Netpr,
      Netwr,
      Werks,
      _Header : redirected to parent ZClaude_C_PO_Header
}
