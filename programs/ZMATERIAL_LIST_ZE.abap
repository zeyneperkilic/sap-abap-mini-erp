REPORT zmaterial_list_ze.

TABLES: zmaterials_ze.

DATA: it_materials TYPE TABLE OF zmaterials_ze,
      wa_material  TYPE zmaterials_ze.

DATA: gr_alv_grid  TYPE REF TO cl_gui_alv_grid,
      gr_container TYPE REF TO cl_gui_custom_container.

DATA: gs_layout    TYPE lvc_s_layo,
      it_fieldcat  TYPE lvc_t_fcat,
      wa_fieldcat  TYPE lvc_s_fcat.

START-OF-SELECTION.

  SELECT * INTO TABLE it_materials FROM zmaterials_ze.

  IF sy-subrc <> 0.
    MESSAGE 'No materials found.' TYPE 'I'.
    EXIT.
  ENDIF.

 
  CALL SCREEN 100.

*---------------------------------------------------------------------*
* SCREEN 100                                                          *
*---------------------------------------------------------------------*

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STANDARD'.

  IF gr_container IS INITIAL.
    
    CREATE OBJECT gr_container
      EXPORTING container_name = 'ALV_CONTAINER'.

    CREATE OBJECT gr_alv_grid
      EXPORTING i_parent = gr_container.


    PERFORM build_fieldcatalog.

    CALL METHOD gr_alv_grid->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout

      CHANGING
         it_fieldcatalog = it_fieldcat
        it_outtab        = it_materials.
  ENDIF.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

*---------------------------------------------------------------------*
* Field Catalog                                                       *
*---------------------------------------------------------------------*

FORM build_fieldcatalog.

  CLEAR it_fieldcat.

  DEFINE add_field.
    CLEAR wa_fieldcat.
    wa_fieldcat-fieldname = &1.
    wa_fieldcat-coltext   = &2.
    APPEND wa_fieldcat TO it_fieldcat.
  END-OF-DEFINITION.

  add_field 'MATERIAL_ID'     'Material ID'.
  add_field 'MATERIAL_NAME'   'Material Name'.
  add_field 'UNIT'            'Unit'.
  add_field 'MATERIAL_GROUP'  'Group'.

ENDFORM.
