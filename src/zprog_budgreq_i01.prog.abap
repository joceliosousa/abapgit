*&---------------------------------------------------------------------*
*& Include          ZPROG_BUDGREQ_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Include ZPROG_BUDREQ_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module USER_COMMAND_0100 INPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  save_ok = ok_code .
  CLEAR ok_code .
  CASE save_ok .
    WHEN '&SAVE'.
      PERFORM f_save_req .
    WHEN OTHERS.
  ENDCASE.
ENDMODULE. " USER_COMMAND_0100 INPUT
*&---------------------------------------------------------------------*
*& Module EXIT_APP INPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE exit_app INPUT.
  LEAVE TO SCREEN 0 .
ENDMODULE. " EXIT_APP INPUT
*&---------------------------------------------------------------------*
*& Module CHECK_FIELDS INPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE check_fields INPUT.
  IF zstbudg_req-reqname IS INITIAL OR
  zstbudg_req-req_amount IS INITIAL OR
  zstbudg_req-waers IS INITIAL .
    MESSAGE 'Please fill required fields' TYPE 'E' .
  ENDIF .
ENDMODULE. " CHECK_FIELDS INPUT
*&---------------------------------------------------------------------*
*& Module USER_COMMAND_0010 INPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE user_command_0010 INPUT.
  PERFORM f_get_data_req .
ENDMODULE. " USER_COMMAND_0010 INPUT
