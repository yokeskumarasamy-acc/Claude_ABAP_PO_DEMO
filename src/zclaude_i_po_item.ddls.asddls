@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: PO Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #TRANSACTIONAL
}
define view entity ZClaude_I_PO_Item
  as select from zclaude_po_item
  association to parent ZClaude_I_PO_Header as _Header
    on $projection.Ebeln = _Header.Ebeln
{
  key ebeln   as Ebeln,
  key ebelp   as Ebelp,
      matnr   as Matnr,
      txz01   as Txz01,
      menge   as Menge,
      meins   as Meins,
      netpr   as Netpr,
      netwr   as Netwr,
      werks   as Werks,
      _Header
}
