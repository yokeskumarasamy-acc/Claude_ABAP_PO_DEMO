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
        po_number   TYPE char10,
        po_item     TYPE char5,
        company     TYPE char4,
        po_type     TYPE char4,
        supplier    TYPE char10,
        po_date     TYPE d,
        pur_org     TYPE char4,
        pur_grp     TYPE char3,
        currency    TYPE char5,
        material    TYPE char18,
        description TYPE char40,
        quantity    TYPE p LENGTH 13 DECIMALS 3,
        unit        TYPE char3,
        net_price   TYPE p LENGTH 11 DECIMALS 2,
        net_value   TYPE p LENGTH 13 DECIMALS 2,
        plant       TYPE char4,
      END OF ty_po_line,
      tt_po_line TYPE STANDARD TABLE OF ty_po_line WITH DEFAULT KEY.

    METHODS build_demo_data
      RETURNING VALUE(rt_po) TYPE tt_po_line.

ENDCLASS.



CLASS zcl_abap_po_report IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_po   TYPE tt_po_line.
    DATA lv_total TYPE p LENGTH 13 DECIMALS 2.

    out->write( '============================================' ).
    out->write( '  Purchase Order Report  (Demo Data)       ' ).
    out->write( '============================================' ).

    lt_po = build_demo_data( ).

    LOOP AT lt_po INTO DATA(ls_po).
      lv_total += ls_po-net_value.
    ENDLOOP.

    out->write( lt_po ).
    out->write( |Total lines : { lines( lt_po ) }| ).
    out->write( |Total Net Value : { lv_total }| ).

  ENDMETHOD.

  METHOD build_demo_data.

    DATA lt_po TYPE tt_po_line.

    lt_po = VALUE #(
      ( po_number = '4500000001' po_item = '00010' company = '1000' po_type = 'NB'
        supplier = 'V-100001'  po_date = '20250101' pur_org = '1000' pur_grp = '001'
        currency = 'USD' material = 'MAT-001' description = 'Steel Rods 10mm'
        quantity = '100' unit = 'KG' net_price = '5.50' net_value = '550.00' plant = '1000' )

      ( po_number = '4500000001' po_item = '00020' company = '1000' po_type = 'NB'
        supplier = 'V-100001'  po_date = '20250101' pur_org = '1000' pur_grp = '001'
        currency = 'USD' material = 'MAT-002' description = 'Aluminium Sheet 2mm'
        quantity = '50'  unit = 'KG' net_price = '12.00' net_value = '600.00' plant = '1000' )

      ( po_number = '4500000002' po_item = '00010' company = '1000' po_type = 'NB'
        supplier = 'V-100002'  po_date = '20250115' pur_org = '1000' pur_grp = '002'
        currency = 'EUR' material = 'MAT-003' description = 'Industrial Bolts M8'
        quantity = '1000' unit = 'EA' net_price = '0.85' net_value = '850.00' plant = '1000' )

      ( po_number = '4500000002' po_item = '00020' company = '1000' po_type = 'NB'
        supplier = 'V-100002'  po_date = '20250115' pur_org = '1000' pur_grp = '002'
        currency = 'EUR' material = 'MAT-004' description = 'Safety Gloves L'
        quantity = '200' unit = 'EA' net_price = '3.20' net_value = '640.00' plant = '1000' )

      ( po_number = '4500000003' po_item = '00010' company = '2000' po_type = 'NB'
        supplier = 'V-200001'  po_date = '20250201' pur_org = '2000' pur_grp = '010'
        currency = 'GBP' material = 'MAT-005' description = 'Copper Wire 1.5mm'
        quantity = '500' unit = 'M'  net_price = '2.10' net_value = '1050.00' plant = '2000' )

      ( po_number = '4500000003' po_item = '00020' company = '2000' po_type = 'NB'
        supplier = 'V-200001'  po_date = '20250201' pur_org = '2000' pur_grp = '010'
        currency = 'GBP' material = 'MAT-006' description = 'Cable Ties 200mm'
        quantity = '300' unit = 'EA' net_price = '0.15' net_value = '45.00' plant = '2000' )

      ( po_number = '4500000004' po_item = '00010' company = '1000' po_type = 'NB'
        supplier = 'V-100003'  po_date = '20250210' pur_org = '1000' pur_grp = '001'
        currency = 'USD' material = 'MAT-007' description = 'Hydraulic Oil 46'
        quantity = '20'  unit = 'L'  net_price = '18.50' net_value = '370.00' plant = '1100' )

      ( po_number = '4500000004' po_item = '00020' company = '1000' po_type = 'NB'
        supplier = 'V-100003'  po_date = '20250210' pur_org = '1000' pur_grp = '001'
        currency = 'USD' material = 'MAT-008' description = 'Filter Element F200'
        quantity = '10'  unit = 'EA' net_price = '45.00' net_value = '450.00' plant = '1100' )

      ( po_number = '4500000005' po_item = '00010' company = '3000' po_type = 'NB'
        supplier = 'V-300001'  po_date = '20250301' pur_org = '3000' pur_grp = '020'
        currency = 'INR' material = 'MAT-009' description = 'Packaging Cartons'
        quantity = '2000' unit = 'EA' net_price = '1.25' net_value = '2500.00' plant = '3000' )

      ( po_number = '4500000005' po_item = '00020' company = '3000' po_type = 'NB'
        supplier = 'V-300001'  po_date = '20250301' pur_org = '3000' pur_grp = '020'
        currency = 'INR' material = 'MAT-010' description = 'Stretch Film Roll'
        quantity = '50'  unit = 'EA' net_price = '220.00' net_value = '11000.00' plant = '3000' )
    ).

    rt_po = lt_po.

  ENDMETHOD.

ENDCLASS.
