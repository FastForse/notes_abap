*----------------------------------------------------------------------*
***INCLUDE ZNOTES_TZ_SCREENS_STATUS_03O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0300 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  IF editor_new IS INITIAL.
    repid = sy-repid.
    CREATE OBJECT custom_container_new
      EXPORTING
        container_name              = 'INPUT_TEXT'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5.

    CREATE OBJECT editor_new
      EXPORTING
        parent                     = custom_container_new
        wordwrap_mode              = cl_gui_textedit=>wordwrap_at_fixed_position
        wordwrap_position          = line_length
        wordwrap_to_linebreak_mode = cl_gui_textedit=>true.
  ENDIF.                 "editor_new is initial

ENDMODULE.
