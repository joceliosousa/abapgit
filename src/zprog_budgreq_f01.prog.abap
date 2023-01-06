*&---------------------------------------------------------------------*
*& Include          ZPROG_BUDGREQ_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Include ZPROG_BUDREQ_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form F_SAVE_REQ
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM f_save_req .
  DATA : ld_nr_range_nr LIKE inri-nrrangenr,
         ld_object      LIKE inri-object,
         ld_number(10)  TYPE n.
  DATA : lwa_db_budgreq TYPE zbudg_req .
  DATA : ld_msg(100) TYPE c .
  ld_nr_range_nr = '01' .
  ld_object = 'ZBUDGREQ' .
  IF sy-tcode = 'ZBUDG01' .
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = ld_nr_range_nr
        object                  = ld_object
      IMPORTING
        number                  = ld_number
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
      MESSAGE 'Number Range Error' TYPE 'E' .
    ENDIF.
    zstbudg_req-budg_reqid = ld_number .
    zstbudg_req-ernam = sy-uname .
    zstbudg_req-erdat = sy-datum .
    zstbudg_req-req_status = const_inprog .
  ENDIF.
  MOVE-CORRESPONDING zstbudg_req TO lwa_db_budgreq .
  " Saving budget request .
  MODIFY zbudg_req FROM lwa_db_budgreq .
  IF sy-subrc = 0.
    COMMIT WORK .
    CONCATENATE 'Budget request' zstbudg_req-budg_reqid 'successfully saved'
    INTO ld_msg SEPARATED BY space .
    CLEAR zstbudg_req .
    MESSAGE ld_msg TYPE 'S' .
  ELSE .
    ROLLBACK WORK .
    MESSAGE 'Error when saving data' TYPE 'E' .
  ENDIF.
ENDFORM. " F_SAVE_REQ
*&---------------------------------------------------------------------*
*& Form F_GET_DATA_REQ
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM f_get_data_req .
  IF zstbudg_req-budg_reqid IS NOT INITIAL.
    SELECT SINGLE * INTO CORRESPONDING FIELDS OF zstbudg_req
    FROM zbudg_req WHERE budg_reqid = zstbudg_req-budg_reqid .
    IF sy-subrc = 0.
      CALL SCREEN '0100' .
    ELSE .
      MESSAGE 'No data found' TYPE 'I' DISPLAY LIKE 'E' .
    ENDIF.
  ENDIF.
ENDFORM. " F_GET_DATA_REQ
