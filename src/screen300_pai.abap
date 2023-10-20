*----------------------------------------------------------------------*
***INCLUDE ZNOTES_TZ_SCREENS_USER_COMMI02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0300 INPUT.

  CASE sy-ucomm.
    WHEN 'NEW'.
      CALL METHOD editor_new->get_text_as_r3table
        IMPORTING
          table = text_tab.                         "######### ##### ### R/3 table

      LOOP AT it_notes INTO note_line.              "######## ######### ######
      ENDLOOP.

      note_line-title = input_title.
      note_line-id_row = note_line-id_row + 1.
      note_line-title_id = note_line-title_id + 1.

      LOOP AT text_tab INTO text_tab_line.
        note_line-content = text_tab_line.          "######### ###### # ##### ####### ## text_tab

        APPEND note_line TO it_notes.

        INSERT INTO znotes_table VALUES @( VALUE #( id_row = note_line-id_row
         title = note_line-title
         content = note_line-content
         title_id = note_line-title_id ) ).

        IF sy-subrc = 0.
          COMMIT WORK.
        ELSE.
          ROLLBACK WORK.
        ENDIF.

        note_line-id_row = note_line-id_row + 1.    "######### ###### ###### ##### id_row + 1
      ENDLOOP.

      MESSAGE '####### ####### #######' TYPE 'S'.
      SET SCREEN 101.
    WHEN 'BACK'.
      SET SCREEN 101.
  ENDCASE.

ENDMODULE.
