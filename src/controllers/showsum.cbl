      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. showsum.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       77 sum-result PIC Z(36).
       
       01 the-vars.
          03  COW-vars      OCCURS 99 TIMES. 
            05 COW-varname  PIC X(99).
            05 COW-varvalue PIC X(99).    

       LINKAGE SECTION.
       01 received-values.
          05 query-values       OCCURS 10 TIMES.
            10 query-value-name PIC X(90).
            10 query-value      PIC X(90).

       PROCEDURE DIVISION USING received-values.

           COMPUTE sum-result = 
              FUNCTION NUMVAL(query-value(1)) 
                 +
              FUNCTION NUMVAL(query-value(2))
           END-COMPUTE.

           MOVE "number1"      TO COW-varname(1).
           
           MOVE query-value(1) TO COW-varvalue(1).
           MOVE "number2"      TO COW-varname(2).
           
           MOVE query-value(2) TO COW-varvalue(2).
           MOVE "number3"      TO COW-varname(3).

           MOVE FUNCTION TRIM(sum-result) TO COW-varvalue(3).


           CALL 'cowtemplate' USING the-vars "showsum.cow" END-CALL.
      
           GOBACK.
