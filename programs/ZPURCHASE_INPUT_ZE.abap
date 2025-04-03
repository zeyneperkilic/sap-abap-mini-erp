REPORT ZPURCHASE_INPUT_ZE.


TABLES: zpurchase_orders, zstocks_ze.

PARAMETERS:
  p_or_id   TYPE zpurchase_orders-order_id,
  p_mtr_id TYPE zpurchase_orders-material_id,
  p_quant    TYPE zpurchase_orders-quantity,
  p_supp    TYPE zpurchase_orders-supplier,
  p_date        TYPE zpurchase_orders-order_date.

DATA: wa_order TYPE zpurchase_orders,
      wa_stock TYPE zstocks_ze.

START-OF-SELECTION.


  SELECT SINGLE * INTO wa_stock
    FROM zstocks_ze
    WHERE material_id = p_mtr_id.

  IF sy-subrc <> 0.
    MESSAGE 'Error!' TYPE 'E'.
  ENDIF.


  IF wa_stock-stock_qty < p_quant.
    MESSAGE 'Not enough stock.' TYPE 'E'.
  ENDIF.


  wa_order-order_id      = p_or_id.
  wa_order-material_id   = p_mtr_id.
  wa_order-quantity      = p_quant.
  wa_order-supplier      = p_supp.
  wa_order-order_date    = p_date.


  INSERT zpurchase_orders FROM wa_order.
  IF sy-subrc <> 0.
    MESSAGE 'Not saved!' TYPE 'E'.
  ENDIF.


  wa_stock-stock_qty = wa_stock-stock_qty - p_quant.
  UPDATE zstocks_ze FROM wa_stock.

  IF sy-subrc = 0.
    MESSAGE 'Stock updated.' TYPE 'S'.
  ELSE.
    MESSAGE 'stock not updated!' TYPE 'W'.
  ENDIF.
