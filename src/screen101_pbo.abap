*----------------------------------------------------------------------*
***INCLUDE ZNOTES_TZ_SCREENS_STATUS_01O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0101 OUTPUT.
*SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  CLEAR list_lab.
  CLEAR values.
  CLEAR it_titles.

  LOOP AT it_notes INTO note_line.                              "######### ####### it_titles
    title_exists = abap_false.
    READ TABLE it_titles WITH KEY
    title_id = note_line-title_id TRANSPORTING NO FIELDS.       "####### ######### ###### # ###### title_id

    IF sy-subrc <> 0.
      titles_line-title_id = note_line-title_id.                "#### ###### ###### ### - #########
      titles_line-title    = note_line-title.
      APPEND titles_line TO it_titles.
    ENDIF.
  ENDLOOP.

  param = 'LIST_LAB'.
  LOOP AT it_titles INTO titles_line.

    value-key = titles_line-title_id.                           "######### values ### ####### # List Box
    value-text = titles_line-title.

    APPEND value TO values.

  ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = param
      values = values.



ENDMODULE.
