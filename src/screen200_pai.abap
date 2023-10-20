*----------------------------------------------------------------------*
***INCLUDE ZNOTES_TZ_SCREENS_USER_COMMI03.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE sy-ucomm.
    WHEN 'SAVE'.
      CALL METHOD editor_view->get_text_as_r3table  "Сохраняем текст как R/3 table
        IMPORTING
          table = text_tab.

      LOOP AT it_titles INTO titles_line.

        IF titles_line-title_id = list_lab.         "Поменять название в таблице с заголовками заметок
          titles_line-title = view_title.
        ENDIF.

      ENDLOOP.

      DELETE it_notes                               "Удаление и заведение заметок заново
      WHERE title_id = list_lab.

      DELETE FROM znotes_table
      WHERE title_id = list_lab.

      LOOP AT it_notes INTO note_line.              "Получение последней строки
      ENDLOOP.

      LOOP AT text_tab INTO text_tab_line.

        note_line-id_row = note_line-id_row + 1.    "Каждая следующая запись имеет id_row на 1 больше предыдущей
        note_line-title_id = list_lab.
        note_line-title = view_title.               "Заполняем запись информацией о заметке
        note_line-content = text_tab_line.

        APPEND note_line TO it_notes.               "Добавляем в it_notes

        INSERT INTO znotes_table VALUES @( VALUE #( id_row = note_line-id_row
         title = note_line-title
         content = note_line-content                "Добавляем в внешнюю tab
         title_id = note_line-title_id ) ).

        IF sy-subrc = 0.
          COMMIT WORK.
        ELSE.
          ROLLBACK WORK.
        ENDIF.

      ENDLOOP.

      MESSAGE 'Заметка успешно изменена' TYPE 'S'.
      SET SCREEN 101.
    WHEN 'BACK'.
      SET SCREEN 101.
  ENDCASE.

ENDMODULE.
