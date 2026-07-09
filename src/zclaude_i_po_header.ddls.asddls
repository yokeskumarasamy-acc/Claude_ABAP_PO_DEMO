@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO Header - Interface View'
define root view entity ZClaude_I_PO_Header
  as select from zcld_po_header
  association [0..*] to ZClaude_I_PO_Item as _Item
    on $projection.PurchaseOrder = _Item.PurchaseOrder
{
  key ebeln as PurchaseOrder,
      bukrs as CompanyCode,
      bsart as DocumentType,
      lifnr as Supplier,
      bedat as DocumentDate,
      ekorg as PurchOrg,
      ekgrp as PurchGroup,
      waers as Currency,
      _Item
}
