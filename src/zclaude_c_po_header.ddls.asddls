@EndUserText.label: 'Projection View: PO Header'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZClaude_C_PO_Header
  provider contract transactional_query
  as projection on ZClaude_I_PO_Header
{
  key Ebeln,
      Bukrs,
      Bsart,
      Lifnr,
      Bedat,
      Ekorg,
      Ekgrp,
      Waers,
      _Item : redirected to composition child ZClaude_C_PO_Item
}
