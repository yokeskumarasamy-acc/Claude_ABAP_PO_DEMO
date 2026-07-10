class ZCL_SO_DISPLAY definition
  public
  final
  create public .

public section.
  interfaces IF_OO_ADT_CLASSRUN .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SO_DISPLAY IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Reads all rows from ZCLD_SO_ITM and prints them as a formatted table
    " Fetch sales order items from the table
    SELECT vbeln, posnr, matnr, arktx, kwmeng, vrkme, netpr, netwr, werks
      FROM zcld_so_itm
      ORDER BY vbeln, posnr
      INTO TABLE @DATA(lt_item).

    IF lt_item IS INITIAL.
      out->write( 'No sales order items found. Run ZCL_SO_LOAD first.' ).
      RETURN.
    ENDIF.

    " Header line
    out->write( |{ 'Sales Order' WIDTH = 12 } | &&
                |{ 'Item' WIDTH = 6 } | &&
                |{ 'Material' WIDTH = 12 } | &&
                |{ 'Description' WIDTH = 18 } | &&
                |{ 'Qty' WIDTH = 10 ALIGN = RIGHT } | &&
                |{ 'Un' WIDTH = 3 } | &&
                |{ 'NetPrice' WIDTH = 12 ALIGN = RIGHT } | &&
                |{ 'NetValue' WIDTH = 14 ALIGN = RIGHT } | &&
                |{ 'Plant' WIDTH = 6 }| ).
    out->write( |{ '' WIDTH = 100 PAD = '-' }| ).

    " Detail lines
    LOOP AT lt_item INTO DATA(ls_item).
      out->write( |{ ls_item-vbeln WIDTH = 12 } | &&
                  |{ ls_item-posnr WIDTH = 6 } | &&
                  |{ ls_item-matnr WIDTH = 12 } | &&
                  |{ ls_item-arktx WIDTH = 18 } | &&
                  |{ ls_item-kwmeng WIDTH = 10 ALIGN = RIGHT } | &&
                  |{ ls_item-vrkme WIDTH = 3 } | &&
                  |{ ls_item-netpr WIDTH = 12 ALIGN = RIGHT } | &&
                  |{ ls_item-netwr WIDTH = 14 ALIGN = RIGHT } | &&
                  |{ ls_item-werks WIDTH = 6 }| ).
    ENDLOOP.

    out->write( |{ '' WIDTH = 100 PAD = '-' }| ).
    out->write( |Total items displayed: { lines( lt_item ) }| ).

  ENDMETHOD.

ENDCLASS.
