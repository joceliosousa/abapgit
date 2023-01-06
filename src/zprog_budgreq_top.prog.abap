*&---------------------------------------------------------------------*
*& Include ZPROG_BUDGREQ_TOP                        - PoolMóds.        ZPROG_BUDGREQ
*&---------------------------------------------------------------------*
PROGRAM zprog_budgreq.

TABLES : zstbudg_req .
CONSTANTS : const_inprog        TYPE char1 VALUE 'I' , " In Progress
            const_approved      TYPE char1 VALUE 'A' , " Approved
            const_text_inporg   TYPE text50 VALUE 'In Progress',
            const_text_approved TYPE text50 VALUE 'Approved'.
DATA : ok_code LIKE sy-ucomm,
       save_ok LIKE sy-ucomm.
DATA : gd_stattext TYPE text50 .
DATA : it_exl TYPE TABLE OF sy-ucomm .
