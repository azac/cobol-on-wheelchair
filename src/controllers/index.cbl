      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. indexweb.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 the-vars.
          03  COW-vars      OCCURS 99 TIMES.
            05 COW-varname  PIC X(99).
            05 COW-varvalue PIC X(99).

       PROCEDURE DIVISION.
           CALL 'cowtemplate' USING the-vars "index.cow" END-CALL.
           GOBACK.
