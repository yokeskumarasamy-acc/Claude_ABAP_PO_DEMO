*&---------------------------------------------------------------------*
*& Report  ZCLABAP_PO_REPORT
*& Purchase Order List Report - EKKO / EKPO
*&---------------------------------------------------------------------*
REPORT zclabap_po_report.

TYPES: BEGIN OF ty_po_display,
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
       END OF ty_po_display.

DATA: lt_po_display   TYPE STANDARD TABLE OF ty_po_display,
      lo_alv          TYPE REF TO cl_salv_table,
      lo_functions    TYPE REF TO cl_salv_functions_list,
      lo_columns      TYPE REF TO cl_salv_columns_table,
      lo_column       TYPE REF TO cl_salv_column_table,
      lo_aggregations TYPE REF TO cl_salv_aggregations,
      lo_display      TYPE REF TO cl_salv_display_settings,
      lx_salv_msg     TYPE REF TO cx_salv_msg.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_ebeln FOR ekko-ebeln,
                  so_bukrs FOR ekko-bukrs,
                  so_bedat FOR ekko-bedat,
                  so_bsart FOR ekko-bsart.
SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
  TEXT-001 = 'Selection Criteria'.

START-OF-SELECTION.

  SELECT ekko~ebeln
         ekpo~ebelp
         ekko~bukrs
         ekko~bsart
         ekko~lifnr
         ekko~bedat
         ekko~ekorg
         ekko~ekgrp
         ekko~waers
         ekpo~matnr
         ekpo~txz01
         ekpo~menge
         ekpo~meins
         ekpo~netpr
         ekpo~netwr
         ekpo~werks
    INTO TABLE lt_po_display
    FROM ekko
    INNER JOIN ekpo ON ekko~ebeln = ekpo~ebeln
    WHERE ekko~ebeln IN so_ebeln
      AND ekko~bukrs IN so_bukrs
      AND ekko~bedat IN so_bedat
      AND ekko~bsart IN so_bsart
      AND ekpo~loekz = ' '
    UP TO 500 ROWS.

  IF sy-subrc <> 0 OR lt_po_display IS INITIAL.
    MESSAGE 'No purchase orders found for the given selection.' TYPE 'I'.
    LEAVE LIST-PROCESSING.
  ENDIF.

END-OF-SELECTION.

  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = lt_po_display
      ).

      lo_functions = lo_alv->get_functions( ).
      lo_functions->set_all( abap_true ).

      lo_display = lo_alv->get_display_settings( ).
      lo_display->set_list_header( 'Purchase Order Report - EKKO / EKPO' ).
      lo_display->set_striped_pattern( abap_true ).

      lo_columns = lo_alv->get_columns( ).
      lo_columns->set_optimize( abap_true ).

      lo_column ?= lo_columns->get_column( 'EBELN' ).
      lo_column->set_long_text( 'Purchase Order No.' ).

      lo_column ?= lo_columns->get_column( 'EBELP' ).
      lo_column->set_long_text( 'PO Item Number' ).

      lo_column ?= lo_columns->get_column( 'BUKRS' ).
      lo_column->set_long_text( 'Company Code' ).

      lo_column ?= lo_columns->get_column( 'BSART' ).
      lo_column->set_long_text( 'Document Type' ).

      lo_column ?= lo_columns->get_column( 'LIFNR' ).
      lo_column->set_long_text( 'Vendor Number' ).

      lo_column ?= lo_columns->get_column( 'BEDAT' ).
      lo_column->set_long_text( 'Purchase Order Date' ).

      lo_column ?= lo_columns->get_column( 'EKORG' ).
      lo_column->set_long_text( 'Purchasing Organisation' ).

      lo_column ?= lo_columns->get_column( 'EKGRP' ).
      lo_column->set_long_text( 'Purchasing Group' ).

      lo_column ?= lo_columns->get_column( 'WAERS' ).
      lo_column->set_long_text( 'Currency Key' ).

      lo_column ?= lo_columns->get_column( 'MATNR' ).
      lo_column->set_long_text( 'Material Number' ).

      lo_column ?= lo_columns->get_column( 'TXZ01' ).
      lo_column->set_long_text( 'Item Description' ).

      lo_column ?= lo_columns->get_column( 'MENGE' ).
      lo_column->set_long_text( 'Order Quantity' ).

      lo_column ?= lo_columns->get_column( 'MEINS' ).
      lo_column->set_long_text( 'Unit of Measure' ).

      lo_column ?= lo_columns->get_column( 'NETPR' ).
      lo_column->set_long_text( 'Net Price per Unit' ).

      lo_column ?= lo_columns->get_column( 'NETWR' ).
      lo_column->set_long_text( 'Net Order Value' ).

      lo_column ?= lo_columns->get_column( 'WERKS' ).
      lo_column->set_long_text( 'Delivery Plant' ).

      lo_aggregations = lo_alv->get_aggregations( ).
      lo_aggregations->add_aggregation(
        columnname  = 'NETWR'
        aggregation = if_salv_c_aggregation=>total
      ).

      lo_alv->display( ).

    CATCH cx_salv_msg INTO lx_salv_msg.
      MESSAGE lx_salv_msg->get_text( ) TYPE 'E'.
  ENDTRY.
