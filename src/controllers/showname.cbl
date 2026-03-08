      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. showname.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 the-vars.
          03  COW-vars     OCCURS 99 TIMES.
            05 COW-varname  PIC X(99).
            05 COW-varvalue PIC X(99).    

       LINKAGE SECTION.
       01 the-values.
          05 COW-query-values       OCCURS 10 TIMES.
            10 COW-query-value-name PIC X(90).
            10 COW-query-value      PIC X(90).


       PROCEDURE DIVISION USING the-values.
           
           MOVE "username" TO COW-varname(1).
           MOVE COW-query-value(1) TO COW-varvalue(1).   

           CALL 'cowtemplate' USING the-vars "hello.cow" END-CALL.
      
           GOBACK.
