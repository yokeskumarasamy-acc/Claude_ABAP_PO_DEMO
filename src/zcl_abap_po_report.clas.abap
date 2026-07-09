CLASS zcl_abap_po_report DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_po_line,
        ebeln TYPE ekko-ebeln,
        ebelp TYPE ekpo-ebelp,
        bukrs TYPE ekko-bukrs,
        bsart TYPE ekko-bsart,
        lifnr TYPE ekko-lifnr,
        bedat TYPE ekko-bedat,
        ekorg TYPE ekko-ekorg,
        ekgrp TYPE ekko-ekgrp,
        waers TYPE ekko-waers,
        matnr TYPE ekpo-matnr,
        txz01 TYPE ekpo-txz01,
        menge TYPE ekpo-menge,
        meins TYPE ekpo-meins,
        netpr TYPE ekpo-netpr,
        netwr TYPE ekpo-netwr,
        werks TYPE ekpo-werks,
      END OF ty_po_line,
      tt_po_line TYPE STANDARD TABLE OF ty_po_line WITH DEFAULT KEY.

ENDCLASS.



CLASS zcl_abap_po_report IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_po TYPE tt_po_line.

    out->write( '=== Purchase Order Report - EKKO / EKPO ===' ).

    SELECT ekko~ebeln,
           ekpo~ebelp,
           ekko~bukrs,
           ekko~bsart,
           ekko~lifnr,
           ekko~bedat,
           ekko~ekorg,
           ekko~ekgrp,
           ekko~waers,
           ekpo~matnr,
           ekpo~txz01,
           ekpo~menge,
           ekpo~meins,
           ekpo~netpr,
           ekpo~netwr,
           ekpo~werks
      FROM ekko
      INNER JOIN ekpo ON ekko~ebeln = ekpo~ebeln
      WHERE ekpo~loekz = ' '
      ORDER BY ekko~ebeln, ekpo~ebelp
      UP TO 500 ROWS
      INTO TABLE @lt_po.

    IF sy-subrc <> 0 OR lt_po IS INITIAL.
      out->write( 'No purchase orders found.' ).
      RETURN.
    ENDIF.

    out->write( |{ lines( lt_po ) } purchase order line(s) found.| ).
    out->write( lt_po ).

  ENDMETHOD.

ENDCLASS.
