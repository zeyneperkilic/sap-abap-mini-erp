REPORT zstock_insert_ze.

DATA: lt_materials TYPE TABLE OF zmaterials_ze,
      wa_material  TYPE zmaterials_ze,
      wa_stock     TYPE zstocks_ze.

SELECT * FROM zmaterials_ze INTO TABLE lt_materials.

LOOP AT lt_materials INTO wa_material.

 SELECT SINGLE * FROM zstocks_ze
  INTO wa_stock
  WHERE material_id = wa_material-material_id.


  IF sy-subrc <> 0.
   
    wa_stock-material_id = wa_material-material_id.
    wa_stock-stock_qty   = 20. 
    INSERT zstocks_ze FROM wa_stock.
  ENDIF.

ENDLOOP.

MESSAGE 'done.' TYPE 'S'.
