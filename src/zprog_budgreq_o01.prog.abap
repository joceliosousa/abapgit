*&---------------------------------------------------------------------*
*& Include          ZPROG_BUDGREQ_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Include ZPROG_BUDREQ_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
CLEAR it_exl .
IF sy-tcode = 'ZBUDG03'.
  APPEND '&SAVE' TO it_exl .
ENDIF.
SET PF-STATUS 'STAT100' EXCLUDING it_exl .
CASE sy-tcode .
  WHEN 'ZBUDG01'.
    SET TITLEBAR 'TIT100' WITH 'Create' .
  WHEN 'ZBUDG03'.
    SET TITLEBAR 'TIT100' WITH 'Display' .
  WHEN OTHERS.
ENDCASE.
ENDMODULE. " STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*& Module STATUS_0010 OUTPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE status_0010 OUTPUT.
  SET PF-STATUS 'STAT10'.
  SET TITLEBAR 'TIT10'.
ENDMODULE. " STATUS_0010 OUTPUT
*&---------------------------------------------------------------------*
*& Module SET_SCREEN OUTPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE set_screen OUTPUT.
  LOOP AT SCREEN .
    IF sy-tcode = 'ZBUDG03' .
      screen-input = 0 .
      MODIFY SCREEN .
    ENDIF.
  ENDLOOP.
ENDMODULE. " SET_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*& Module SET_STATTEXT OUTPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE set_stattext OUTPUT.
  CLEAR gd_stattext .
  CASE zstbudg_req-req_status.
    WHEN const_inprog.
      gd_stattext = const_text_inporg .
    WHEN const_approved.
      gd_stattext = const_text_approved .
    WHEN OTHERS.
  ENDCASE.
ENDMODULE. " SET_STATTEXT OUTPUT
