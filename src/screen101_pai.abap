*----------------------------------------------------------------------*
***INCLUDE ZNOTES_TZ_SCREENS_USER_COMMI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0101  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0101 INPUT.
  CASE sy-ucomm.
    WHEN 'DEL'.
      DELETE it_notes                             "####### ####### ## itab it_notes
      WHERE title_id = list_lab.

      DELETE FROM znotes_table                    "####### ####### ## ####### tab
      WHERE title_id = list_lab.

      IF sy-subrc = 0.
        COMMIT WORK.
      ELSE.
        ROLLBACK WORK.
      ENDIF.

      MESSAGE '####### ####### #######' TYPE 'S'.
      SET SCREEN 101.
    WHEN 'EXIT'.
      SET SCREEN 0.
    WHEN 'NEW'.
      SET SCREEN 300.
    WHEN 'EDIT'.
      SET SCREEN 200.
  ENDCASE.
ENDMODULE.
