@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: PO Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #TRANSACTIONAL
}
define view entity ZClaude_I_PO_Header
  as select from zcld_po_header
  composition [0..*] of ZClaude_I_PO_Item as _Item
{
  key ebeln   as Ebeln,
      bukrs   as Bukrs,
      bsart   as Bsart,
      lifnr   as Lifnr,
      bedat   as Bedat,
      ekorg   as Ekorg,
      ekgrp   as Ekgrp,
      waers   as Waers,
      _Item
}
