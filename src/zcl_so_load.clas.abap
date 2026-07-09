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

    " Generates 105 sales orders (5 original + 100 more) and 210 items
    " Material catalogue used to build items
    TYPES: BEGIN OF ty_mat,
             matnr TYPE zcld_so_itm-matnr,
             arktx TYPE zcld_so_itm-arktx,
             netpr TYPE zcld_so_itm-netpr,
             meins TYPE zcld_so_itm-vrkme,
             werks TYPE zcld_so_itm-werks,
           END OF ty_mat.

    DATA(lt_mat) = VALUE STANDARD TABLE OF ty_mat(
      ( matnr = 'MAT-1000' arktx = 'Office Chair'    netpr = '150.00'  meins = 'EA' werks = '1000' )
      ( matnr = 'MAT-2000' arktx = 'Laptop Computer' netpr = '800.00'  meins = 'EA' werks = '1000' )
      ( matnr = 'MAT-3000' arktx = 'Steel Pipes'     netpr = '5.00'    meins = 'KG' werks = '2000' )
      ( matnr = 'MAT-4000' arktx = 'Safety Helmets'  netpr = '15.00'   meins = 'EA' werks = '2000' )
      ( matnr = 'MAT-5000' arktx = 'Server Hardware' netpr = '5000.00' meins = 'EA' werks = '3000' ) ).

    DATA(lt_org)  = VALUE stringtab( ( `1000` ) ( `2000` ) ( `3000` ) ).
    DATA(lt_curr) = VALUE stringtab( ( `USD` ) ( `EUR` ) ( `GBP` ) ).

    DATA lt_header TYPE TABLE OF zcld_so_header.
    DATA lt_item   TYPE TABLE OF zcld_so_itm.
    DATA lv_total  TYPE zcld_so_header-netwr.

    " 105 sales orders, 2 items each
    DO 105 TIMES.
      DATA(lv_n)     = sy-index.
      DATA(lv_vbeln) = CONV zcld_so_header-vbeln( |{ lv_n + 10000 WIDTH = 10 ALIGN = RIGHT PAD = '0' }| ).
      DATA(lv_org)   = lt_org[ ( lv_n MOD 3 ) + 1 ].
      DATA(lv_curr)  = lt_curr[ ( lv_n MOD 3 ) + 1 ].

      CLEAR lv_total.

      DO 2 TIMES.
        DATA(lv_pos)   = sy-index.
        DATA(lv_mat)   = lt_mat[ ( ( lv_n + lv_pos ) MOD 5 ) + 1 ].
        DATA(lv_qty)   = CONV zcld_so_itm-kwmeng( ( lv_n MOD 10 ) + 1 ).
        DATA(lv_netwr) = CONV zcld_so_itm-netwr( lv_qty * lv_mat-netpr ).
        lv_total += lv_netwr.

        APPEND VALUE #( vbeln  = lv_vbeln
                        posnr  = CONV zcld_so_itm-posnr( lv_pos * 10 )
                        matnr  = lv_mat-matnr
                        arktx  = lv_mat-arktx
                        kwmeng = lv_qty
                        vrkme  = lv_mat-meins
                        netpr  = lv_mat-netpr
                        netwr  = lv_netwr
                        werks  = lv_mat-werks ) TO lt_item.
      ENDDO.

      APPEND VALUE #( vbeln = lv_vbeln
                      kunnr = CONV zcld_so_header-kunnr( |{ lv_n + 200000 WIDTH = 10 ALIGN = RIGHT PAD = '0' }| )
                      auart = 'TA'
                      erdat = '20240101'
                      vkorg = lv_org
                      netwr = lv_total
                      waerk = lv_curr ) TO lt_header.
    ENDDO.

    DELETE FROM zcld_so_header.
    INSERT zcld_so_header FROM TABLE @lt_header.
    COMMIT WORK AND WAIT.
    out->write( |{ lines( lt_header ) } sales order headers loaded.| ).

    DELETE FROM zcld_so_itm.
    INSERT zcld_so_itm FROM TABLE @lt_item.
    COMMIT WORK AND WAIT.
    out->write( |{ lines( lt_item ) } sales order items loaded.| ).
    out->write( 'Sales Order data load complete!' ).

  ENDMETHOD.

ENDCLASS.
