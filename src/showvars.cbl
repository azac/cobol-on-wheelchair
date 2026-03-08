      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. showvars.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77 ctr PIC X(2) USAGE COMP-5.

       LINKAGE SECTION.
       01 the-values.
          05 query-values       OCCURS 10 TIMES.
            10 query-value-name PIC X(90).
            10 query-value      PIC X(90).


       PROCEDURE DIVISION USING the-values.
           
           DISPLAY
           "<"
           "table cellpadding=10 "
           "border=1 "
           "cellspacing=4 "
           "bgcolor=lightgray"
           ">".

           PERFORM VARYING ctr FROM 1 BY 1 UNTIL ctr > 10
           
           DISPLAY "<tr><td>" query-value-name(ctr)
                   "</td><td>" query-value(ctr) "</td></tr>"
           
           END-PERFORM


           DISPLAY "</table>".
      
           GOBACK.
