REPORT ZMATERIAL_INPUT_ZE.


TABLES: zmaterials_ze.

PARAMETERS:
  p_matid  TYPE zmaterials_ze-material_id,
  p_name   TYPE zmaterials_ze-material_name,
  p_unit   TYPE zmaterials_ze-unit,
  p_group  TYPE zmaterials_ze-material_group.


START-OF-SELECTION.

  DATA: wa_material TYPE zmaterials_ze.


  SELECT SINGLE * FROM zmaterials_ze INTO wa_material WHERE material_id = p_matid.
  IF sy-subrc = 0.
    MESSAGE 'Already Saved!' TYPE 'E'.
  ENDIF.


  wa_material-material_id    = p_matid.
  wa_material-material_name  = p_name.
  wa_material-unit           = p_unit.
  wa_material-material_group = p_group.

  INSERT zmaterials_ze FROM wa_material.
  IF sy-subrc = 0.
    MESSAGE 'Material Saved.' TYPE 'S'.
  ELSE.
    MESSAGE 'Error While Material Save!' TYPE 'E'.
  ENDIF.
