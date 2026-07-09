class ZCL_SO_LOAD definition
  public
  final
  create public .

public section.
  interfaces IF_OO_ADT_CLASSRUN .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SO_LOAD IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Load Sales Order Headers
    DATA lt_header TYPE TABLE OF zcld_so_header.
    lt_header = VALUE #(
      ( vbeln = '0000010001' kunnr = '0000200001' auart = 'TA' erdat = '20240105' vkorg = '1000' netwr = '3000.00'  waerk = 'USD' )
      ( vbeln = '0000010002' kunnr = '0000200002' auart = 'TA' erdat = '20240118' vkorg = '1000' netwr = '16500.00' waerk = 'EUR' )
      ( vbeln = '0000010003' kunnr = '0000200003' auart = 'TA' erdat = '20240203' vkorg = '2000' netwr = '1100.00'  waerk = 'USD' )
      ( vbeln = '0000010004' kunnr = '0000200004' auart = 'TA' erdat = '20240215' vkorg = '2000' netwr = '4750.00'  waerk = 'GBP' )
      ( vbeln = '0000010005' kunnr = '0000200005' auart = 'TA' erdat = '20240305' vkorg = '3000' netwr = '13000.00' waerk = 'USD' )
    ).
    DELETE FROM zcld_so_header.
    INSERT zcld_so_header FROM TABLE @lt_header.
    COMMIT WORK AND WAIT.
    out->write( |{ lines( lt_header ) } sales order headers loaded.| ).

    " Load Sales Order Items
    DATA lt_item TYPE TABLE OF zcld_so_itm.
    lt_item = VALUE #(
      ( vbeln = '0000010001' posnr = '000010' matnr = 'MAT-1000' arktx = 'Office Chair'    kwmeng = '10' vrkme = 'EA' netpr = '150.00'  netwr = '1500.00'  werks = '1000' )
      ( vbeln = '0000010001' posnr = '000020' matnr = 'MAT-1001' arktx = 'Office Desk'     kwmeng = '5'  vrkme = 'EA' netpr = '300.00'  netwr = '1500.00'  werks = '1000' )
      ( vbeln = '0000010002' posnr = '000010' matnr = 'MAT-2000' arktx = 'Laptop Computer' kwmeng = '20' vrkme = 'EA' netpr = '800.00'  netwr = '16000.00' werks = '1000' )
      ( vbeln = '0000010002' posnr = '000020' matnr = 'MAT-2001' arktx = 'Wireless Mouse'  kwmeng = '20' vrkme = 'EA' netpr = '25.00'   netwr = '500.00'   werks = '1000' )
      ( vbeln = '0000010003' posnr = '000010' matnr = 'MAT-3000' arktx = 'Steel Pipes'     kwmeng = '100' vrkme = 'KG' netpr = '5.00'  netwr = '500.00'   werks = '2000' )
      ( vbeln = '0000010003' posnr = '000020' matnr = 'MAT-3001' arktx = 'Copper Wire'     kwmeng = '50'  vrkme = 'KG' netpr = '12.00' netwr = '600.00'   werks = '2000' )
      ( vbeln = '0000010004' posnr = '000010' matnr = 'MAT-4000' arktx = 'Safety Helmets'  kwmeng = '200' vrkme = 'EA' netpr = '15.00' netwr = '3000.00'  werks = '2000' )
      ( vbeln = '0000010004' posnr = '000020' matnr = 'MAT-4001' arktx = 'Safety Gloves'   kwmeng = '500' vrkme = 'EA' netpr = '3.50'  netwr = '1750.00'  werks = '2000' )
      ( vbeln = '0000010005' posnr = '000010' matnr = 'MAT-5000' arktx = 'Server Hardware' kwmeng = '2'   vrkme = 'EA' netpr = '5000.00' netwr = '10000.00' werks = '3000' )
      ( vbeln = '0000010005' posnr = '000020' matnr = 'MAT-5001' arktx = 'Network Switch'  kwmeng = '4'   vrkme = 'EA' netpr = '750.00' netwr = '3000.00'  werks = '3000' )
    ).
    DELETE FROM zcld_so_itm.
    INSERT zcld_so_itm FROM TABLE @lt_item.
    COMMIT WORK AND WAIT.
    out->write( |{ lines( lt_item ) } sales order items loaded.| ).
    out->write( 'Sales Order data load complete!' ).

  ENDMETHOD.

ENDCLASS.
