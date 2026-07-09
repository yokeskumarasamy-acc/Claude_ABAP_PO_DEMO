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
        purchaseorder          TYPE i_purchaseorder-purchaseorder,
        purchaseorderitem      TYPE i_purchaseorderitem-purchaseorderitem,
        companycode            TYPE i_purchaseorder-companycode,
        purchaseordertype      TYPE i_purchaseorder-purchaseordertype,
        supplier               TYPE i_purchaseorder-supplier,
        purchaseorderdate      TYPE i_purchaseorder-purchaseorderdate,
        purchasingorganization TYPE i_purchaseorder-purchasingorganization,
        purchasinggroup        TYPE i_purchaseorder-purchasinggroup,
        documentcurrency       TYPE i_purchaseorder-documentcurrency,
        material               TYPE i_purchaseorderitem-material,
        purchaseorderitemtext  TYPE i_purchaseorderitem-purchaseorderitemtext,
        orderquantity          TYPE i_purchaseorderitem-orderquantity,
        purchaseorderitemunit  TYPE i_purchaseorderitem-purchaseorderitemunit,
        netpriceamount         TYPE i_purchaseorderitem-netpriceamount,
        netamount              TYPE i_purchaseorderitem-netamount,
        plant                  TYPE i_purchaseorderitem-plant,
      END OF ty_po_line,
      tt_po_line TYPE STANDARD TABLE OF ty_po_line WITH DEFAULT KEY.

ENDCLASS.



CLASS zcl_abap_po_report IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_po TYPE tt_po_line.

    out->write( '=== Purchase Order Report ===' ).

    SELECT po~purchaseorder,
           poi~purchaseorderitem,
           po~companycode,
           po~purchaseordertype,
           po~supplier,
           po~purchaseorderdate,
           po~purchasingorganization,
           po~purchasinggroup,
           po~documentcurrency,
           poi~material,
           poi~purchaseorderitemtext,
           poi~orderquantity,
           poi~purchaseorderitemunit,
           poi~netpriceamount,
           poi~netamount,
           poi~plant
      FROM i_purchaseorder AS po
      INNER JOIN i_purchaseorderitem AS poi
        ON po~purchaseorder = poi~purchaseorder
      ORDER BY po~purchaseorder, poi~purchaseorderitem
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
