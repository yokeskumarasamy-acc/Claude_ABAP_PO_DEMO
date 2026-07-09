CLASS zcl_abap_po_report DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_abap_po_report IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    out->write( 'PO Report - use ZCL_ABAP_PO_LOAD to load data first.' ).
  ENDMETHOD.

ENDCLASS.
