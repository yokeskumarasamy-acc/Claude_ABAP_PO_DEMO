class ZCL_ABAP_PO_LOAD definition
  public
  final
  create public .

public section.
  interfaces IF_OO_ADT_CLASSRUN .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ABAP_PO_LOAD IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Load PO Headers
    DATA lt_header TYPE TABLE OF zcld_po_header.
    lt_header = VALUE #(
      ( ebeln = '4500000001' bukrs = '1000' bsart = 'NB' lifnr = '0000100001' bedat = '20240101' ekorg = '1000' ekgrp = '001' waers = 'USD' )
      ( ebeln = '4500000002' bukrs = '1000' bsart = 'NB' lifnr = '0000100002' bedat = '20240115' ekorg = '1000' ekgrp = '001' waers = 'EUR' )
      ( ebeln = '4500000003' bukrs = '2000' bsart = 'NB' lifnr = '0000100003' bedat = '20240201' ekorg = '2000' ekgrp = '002' waers = 'USD' )
      ( ebeln = '4500000004' bukrs = '2000' bsart = 'NB' lifnr = '0000100004' bedat = '20240210' ekorg = '2000' ekgrp = '002' waers = 'GBP' )
      ( ebeln = '4500000005' bukrs = '3000' bsart = 'NB' lifnr = '0000100005' bedat = '20240301' ekorg = '3000' ekgrp = '003' waers = 'USD' )
    ).
    DELETE FROM zcld_po_header.
    INSERT zcld_po_header FROM TABLE @lt_header.
    COMMIT WORK AND WAIT.
    out->write( |{ lines( lt_header ) } PO headers loaded.| ).

    " Load PO Items
    DATA lt_item TYPE TABLE OF zcld_po_itm.
    lt_item = VALUE #(
      ( ebeln = '4500000001' ebelp = '00010' matnr = 'MAT-1000' txz01 = 'Office Chair'    menge = '10' meins = 'EA' netpr = '150.00'  netwr = '1500.00'  werks = '1000' )
      ( ebeln = '4500000001' ebelp = '00020' matnr = 'MAT-1001' txz01 = 'Office Desk'     menge = '5'  meins = 'EA' netpr = '300.00'  netwr = '1500.00'  werks = '1000' )
      ( ebeln = '4500000002' ebelp = '00010' matnr = 'MAT-2000' txz01 = 'Laptop Computer' menge = '20' meins = 'EA' netpr = '800.00'  netwr = '16000.00' werks = '1000' )
      ( ebeln = '4500000002' ebelp = '00020' matnr = 'MAT-2001' txz01 = 'Wireless Mouse'  menge = '20' meins = 'EA' netpr = '25.00'   netwr = '500.00'   werks = '1000' )
      ( ebeln = '4500000003' ebelp = '00010' matnr = 'MAT-3000' txz01 = 'Steel Pipes'     menge = '100' meins = 'KG' netpr = '5.00'  netwr = '500.00'   werks = '2000' )
      ( ebeln = '4500000003' ebelp = '00020' matnr = 'MAT-3001' txz01 = 'Copper Wire'     menge = '50'  meins = 'KG' netpr = '12.00' netwr = '600.00'   werks = '2000' )
      ( ebeln = '4500000004' ebelp = '00010' matnr = 'MAT-4000' txz01 = 'Safety Helmets'  menge = '200' meins = 'EA' netpr = '15.00' netwr = '3000.00'  werks = '2000' )
      ( ebeln = '4500000004' ebelp = '00020' matnr = 'MAT-4001' txz01 = 'Safety Gloves'   menge = '500' meins = 'EA' netpr = '3.50'  netwr = '1750.00'  werks = '2000' )
      ( ebeln = '4500000005' ebelp = '00010' matnr = 'MAT-5000' txz01 = 'Server Hardware' menge = '2'   meins = 'EA' netpr = '5000.00' netwr = '10000.00' werks = '3000' )
      ( ebeln = '4500000005' ebelp = '00020' matnr = 'MAT-5001' txz01 = 'Network Switch'  menge = '4'   meins = 'EA' netpr = '750.00' netwr = '3000.00'  werks = '3000' )
    ).
    DELETE FROM zcld_po_itm.
    INSERT zcld_po_itm FROM TABLE @lt_item.
    COMMIT WORK AND WAIT.
    out->write( |{ lines( lt_item ) } PO items loaded.| ).
    out->write( 'Data load complete!' ).

  ENDMETHOD.

ENDCLASS.
