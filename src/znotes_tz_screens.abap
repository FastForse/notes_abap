*&---------------------------------------------------------------------*
*& Report ZNOTES_TZ
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znotes_tz_screens.

TABLES: znotes_table.

TYPES: BEGIN OF ty_notes,
         id_row   TYPE znotes_table-id_row,
         title_id TYPE znotes_table-title_id,                    "######## ######### ######## ####### # #########
         title    TYPE znotes_table-title,
         content  TYPE znotes_table-content,
       END OF ty_notes.

DATA: it_notes  TYPE STANDARD TABLE OF ty_notes WITH EMPTY KEY,  "Itab ######## ####### # ######
      note_line LIKE LINE OF it_notes.


TYPES: BEGIN OF ty_titles,
         title_id TYPE znotes_table-title_id,                    "######## ######### ####### # ########## #######
         title    TYPE znotes_table-title,                       "### ########## list box
       END OF ty_titles.

DATA: it_titles    TYPE STANDARD TABLE OF ty_titles WITH EMPTY KEY,
      titles_line  LIKE LINE OF it_titles,                       "############, ##### ## ######### ########## ########
      title_exists TYPE abap_bool.


TYPE-POOLS : vrm.
DATA: param  TYPE vrm_id,
      values TYPE vrm_values,                                     "########## list box ########## #######
      value  LIKE LINE OF values.

DATA: input_title TYPE znotes_table-title,                      "### ######## ##### #######
      list_lab    TYPE znotes_table-title,                      "### listbox, ###### # ########## #######
      view_title  TYPE znotes_table-title.                      "### ########### ######## ########



DATA: custom_container_view TYPE REF TO cl_gui_custom_container,
      custom_container_new  TYPE REF TO cl_gui_custom_container,
      editor_view           TYPE REF TO cl_gui_textedit,          "########## custom control # ############## SAP TextEdit
      editor_new            TYPE REF TO cl_gui_textedit,
      repid                 LIKE sy-repid.

CONSTANTS: line_length TYPE i VALUE 256.                          "####### ##### ###### TextEdit

DATA: line          TYPE znotes_table-content,
      text_tab      LIKE STANDARD TABLE OF line,                  "############ ### ########## # ########## TextEdit
      text_tab_line LIKE LINE OF text_tab.



INCLUDE znotes_tz_screens_status_01o01.

INCLUDE znotes_tz_screens_user_commi01.

INCLUDE znotes_tz_screens_status_03o01.

INCLUDE znotes_tz_screens_user_commi02.

INCLUDE znotes_tz_screens_status_02o01.

INCLUDE znotes_tz_screens_user_commi03.

INITIALIZATION.

  CLEAR it_notes.
  CLEAR it_titles.
  CLEAR note_line.
  CLEAR titles_line.

  SELECT * FROM znotes_table                                      "######## ####### # it_notes
          INTO CORRESPONDING FIELDS OF TABLE it_notes.


  IF sy-subrc = 4.                                                "# ######, #### ####### ## ########## (########,
                                                                  "### ###### ####### #########), ####### ####-#######
    note_line-id_row = 1.
    note_line-title_id = 1.
    note_line-title = 'Demo'.
    note_line-content = 'Hello World!'.

    APPEND note_line TO it_notes.                                 "######### ########## ####### # ######### #######

    INSERT INTO znotes_table VALUES @( VALUE #( id_row = note_line-id_row
     title = note_line-title
     content = note_line-content
     title_id = note_line-title_id ) ).


    note_line-id_row = 2.
    note_line-title_id = 2.
    note_line-title = '##########'.
    note_line-content = 'Severstal it-hub'.

    APPEND note_line TO it_notes.

    INSERT INTO znotes_table VALUES @( VALUE #( id_row = note_line-id_row
     title = note_line-title
     content = note_line-content
     title_id = note_line-title_id ) ).

    note_line-id_row = 3.
    note_line-title_id = 2.
    note_line-title = '##########'.
    note_line-content = 'The best!'.

    APPEND note_line TO it_notes.

    INSERT INTO znotes_table VALUES @( VALUE #( id_row = note_line-id_row
     title = note_line-title
     content = note_line-content
     title_id = note_line-title_id ) ).

  ENDIF.


  CALL SCREEN 101.
