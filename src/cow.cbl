      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. cow.
      
      *********************************************
      *** Division where variables are declared ***
      ***              and                      ***
      ***        files are described            ***
      *********************************************
      
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       77 WS-newline     PIC X VALUE X'0A'.
       77 analyzed-query PIC X(1600).

       01 the-great-dispatch.
          03 nroutes       PIC 99 USAGE COMP-5.
          03 routing-table OCCURS 10 TIMES.
            05 routing-pattern PIC X(999).
            05 routing-destiny PIC X(999).

       77 tester   PIC X VALUE "n".  
       77 anyfound PIC X VALUE "n".
       77 ctr      PIC 9(2) USAGE COMP-5.

       01 the-values.
          05 query-values OCCURS 10 TIMES.
            10 query-value-name PIC X(90).
            10 query-value      PIC X(90).

      *********************
      *** Program Logic ***
      *********************

       PROCEDURE DIVISION.
      
      ********************************
      *** Initialize of main logic ***
      ********************************
           COPY "config.cbl".
      
      ******************************************
      *** Procedure for print the web header ***
      ******************************************
           PERFORM web-header.
     
      *************************************
      *** Call to the function getquery ***
      *************************************
           CALL "getquery" USING analyzed-query END-CALL.
      
      **********************************
      *** Controller loop for routes ***
      **********************************
           PERFORM VARYING ctr FROM 1 BY 1 UNTIL ctr > nroutes

               CALL 'checkquery'
               
               USING analyzed-query 
      *              Here is a bug that I couldn't fix
      *              because I don't know much about the web
                     routing-pattern(ctr)
                     tester
                     the-values
               
               END-CALL

           END-PERFORM.
      
      *** Conditional for to know if the testes equal true ***
           IF (tester = "y")
           
      *** Display routing-pattern(ctr) "<hr>" ***
               MOVE "y" TO anyfound
           
      *** Display "ctr:" ctr ***
               CALL routing-destiny(ctr) USING the-values END-CALL
           
           END-IF.
      
      *************************************
      *** Check if nothing is available ***
      *************************************

           IF (anyfound = "n")
               PERFORM bad-query-error
      *     ELSE
      *         CALL "showvars" USING the-values.
           END-IF.

      ***********************
      *** Function Return ***
      ***********************
           GOBACK.

      ********************************
      *** Handle erroneous queries ***
      ********************************
       bad-query-error.
           DISPLAY  "<b>Cobol-on-Wheelchair error:</b>"
                    "query pattern not found (<i>"
                    FUNCTION TRIM(analyzed-query) "</i>)".
      
      ************************************
      *** Show which is the web header ***
      ************************************
       web-header.
           DISPLAY "content-type: text/html; charset=utf-8" WS-newline.
