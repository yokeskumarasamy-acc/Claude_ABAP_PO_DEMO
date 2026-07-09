CLASS zcl_abap_po_load DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_abap_po_load IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_header TYPE TABLE OF zcld_po_header.

    lt_header = VALUE #(
      ( mandt = sy-mandt ebeln = '4500000001' bukrs = '1000' bsart = 'NB'
        lifnr = '0000100001' bedat = '20240101' ekorg = '1000' ekgrp = '001' waers = 'USD' )
      ( mandt = sy-mandt ebeln = '4500000002' bukrs = '1000' bsart = 'NB'
        lifnr = '0000100002' bedat = '20240215' ekorg = '1000' ekgrp = '001' waers = 'EUR' )
      ( mandt = sy-mandt ebeln = '4500000003' bukrs = '2000' bsart = 'NB'
        lifnr = '0000100003' bedat = '20240310' ekorg = '2000' ekgrp = '002' waers = 'USD' )
      ( mandt = sy-mandt ebeln = '4500000004' bukrs = '2000' bsart = 'FO'
        lifnr = '0000100004' bedat = '20240401' ekorg = '2000' ekgrp = '002' waers = 'GBP' )
      ( mandt = sy-mandt ebeln = '4500000005' bukrs = '3000' bsart = 'NB'
        lifnr = '0000100005' bedat = '20240501' ekorg = '3000' ekgrp = '003' waers = 'USD' )
    ).

    MODIFY zcld_po_header FROM TABLE @lt_header.
    IF sy-subrc = 0.
      out->write( |{ lines( lt_header ) } PO header records inserted/updated.| ).
    ELSE.
      out->write( |Error inserting PO headers. SY-SUBRC = { sy-subrc }| ).
    ENDIF.

    DATA lt_item TYPE TABLE OF zclaude_po_item.

    lt_item = VALUE #(
      ( mandt = sy-mandt ebeln = '4500000001' ebelp = '00010' matnr = 'MAT-000001'
        txz01 = 'Laptop Computer'       menge = '2' meins = 'EA'
        netpr = '1200' netwr = '2400' werks = 'P001' )
      ( mandt = sy-mandt ebeln = '4500000001' ebelp = '00020' matnr = 'MAT-000002'
        txz01 = 'Wireless Mouse'        menge = '5' meins = 'EA'
        netpr = '25'   netwr = '125'  werks = 'P001' )
      ( mandt = sy-mandt ebeln = '4500000002' ebelp = '00010' matnr = 'MAT-000003'
        txz01 = 'Office Chair'          menge = '10' meins = 'EA'
        netpr = '350'  netwr = '3500' werks = 'P001' )
      ( mandt = sy-mandt ebeln = '4500000002' ebelp = '00020' matnr = 'MAT-000004'
        txz01 = 'Standing Desk'         menge = '5' meins = 'EA'
        netpr = '600'  netwr = '3000' werks = 'P002' )
      ( mandt = sy-mandt ebeln = '4500000003' ebelp = '00010' matnr = 'MAT-000005'
        txz01 = 'Industrial Pump'       menge = '2' meins = 'EA'
        netpr = '4500' netwr = '9000' werks = 'P002' )
      ( mandt = sy-mandt ebeln = '4500000003' ebelp = '00020' matnr = 'MAT-000006'
        txz01 = 'Hydraulic Hose 10m'    menge = '20' meins = 'M'
        netpr = '45'   netwr = '900'  werks = 'P002' )
      ( mandt = sy-mandt ebeln = '4500000004' ebelp = '00010' matnr = 'MAT-000007'
        txz01 = 'Steel Plate 4mm'       menge = '100' meins = 'KG'
        netpr = '4'    netwr = '400'  werks = 'P003' )
      ( mandt = sy-mandt ebeln = '4500000004' ebelp = '00020' matnr = 'MAT-000008'
        txz01 = 'Aluminium Rod 6m'      menge = '50' meins = 'EA'
        netpr = '18'   netwr = '900'  werks = 'P003' )
      ( mandt = sy-mandt ebeln = '4500000005' ebelp = '00010' matnr = 'MAT-000009'
        txz01 = 'Safety Helmet'         menge = '30' meins = 'EA'
        netpr = '22'   netwr = '660'  werks = 'P003' )
      ( mandt = sy-mandt ebeln = '4500000005' ebelp = '00020' matnr = 'MAT-000010'
        txz01 = 'Safety Gloves'         menge = '100' meins = 'PR'
        netpr = '9'    netwr = '900'  werks = 'P003' )
    ).

    MODIFY zclaude_po_item FROM TABLE @lt_item.
    IF sy-subrc = 0.
      out->write( |{ lines( lt_item ) } PO item records inserted/updated.| ).
    ELSE.
      out->write( |Error inserting PO items. SY-SUBRC = { sy-subrc }| ).
    ENDIF.

    COMMIT WORK AND WAIT.
    out->write( 'Data load complete.' ).

  ENDMETHOD.

ENDCLASS.
