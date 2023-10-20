*----------------------------------------------------------------------*
***INCLUDE ZNOTES_TZ_SCREENS_STATUS_02O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  CLEAR note_line.
  READ TABLE it_notes WITH KEY id_row = list_lab INTO note_line.      "Получаем название заметки и title_id

  IF editor_view IS INITIAL.
    repid = sy-repid.
    CREATE OBJECT custom_container_view
      EXPORTING
        container_name              = 'VIEW_TEXT'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5.

    CREATE OBJECT editor_view
      EXPORTING
        parent                     = custom_container_view
        wordwrap_mode              = cl_gui_textedit=>wordwrap_at_fixed_position
        wordwrap_position          = line_length
        wordwrap_to_linebreak_mode = cl_gui_textedit=>true.
  ENDIF.                 "editor_view is initial

  CLEAR text_tab.

  LOOP AT it_notes INTO note_line WHERE title_id = LIST_LAB .

    APPEND note_line-content TO text_tab.                       "Заполняем text_tab строками из it_notes одной
                                                                "нужной заметки
    ENDLOOP.

  editor_view->set_text_as_stream( EXPORTING text = text_tab ). "Вставляем содержание text_tab в окно textedit

  view_title = note_line-title.                                 "Отображаем название заметки

ENDMODULE.
