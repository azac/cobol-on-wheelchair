      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. checkquery.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 choppery.   
          05 chopped-path-pieces   OCCURS 99 TIMES.
             10 chopped-path-piece PIC X(80) VALUE SPACES. 
          
          05 chopped-pattern-pieces   OCCURS 99 TIMES.
             10 chopped-pattern-piece PIC X(80) VALUE SPACES.
                                                                    
       77 counter       PIC S9(04) COMP. 
       77 positio       PIC S9(04).
       77 tmp-pointer   PIC S9(04) COMP VALUE +1. 
       77 tmp-pointer2  PIC S9(04) COMP VALUE +1. 

       77 counter-of-values PIC S9(2).
       
       01 query-analysis.
          05 query-values       OCCURS 10 TIMES.
            10 query-value-name PIC X(90).
            10 query-value      PIC X(90).

       LINKAGE SECTION.

       77 the-query   PIC X(255).
       77 the-pattern PIC X(255).
       77 result      PIC X(001).

       01 query-analysis-out.
          05 query-values-out       OCCURS 10 TIMES.
            10 query-value-name-out PIC X(90).
            10 query-value-out      PIC X(90).

       PROCEDURE DIVISION USING the-query
                                the-pattern
                                result
                                query-analysis-out.

      ****************************
      *** Initialize variables ***
      ****************************

           MOVE SPACES TO choppery.
           MOVE "y"    TO result.
           MOVE 0      TO counter-of-values.

      ***************************
      *** Initialize pointers ***
      ***************************
           MOVE 1 TO tmp-pointer.
           MOVE 1 TO tmp-pointer2.

      *******************************************************
      ***         Split both the requested route          ***
      ***      and the pattern route into individual      ***
      *** segments using the character ‘/’ as a delimiter ***
      *******************************************************

           PERFORM VARYING counter FROM 2 BY 1 UNTIL counter > 99   
               
               SUBTRACT 1 FROM counter GIVING positio
                   UNSTRING the-query DELIMITED BY '/'          
                   INTO chopped-path-piece(positio)                    
                   WITH POINTER tmp-pointer    

               UNSTRING the-pattern DELIMITED BY '/'          
                   INTO chopped-pattern-piece(positio)                    
                   WITH POINTER tmp-pointer2   

           END-PERFORM.
      
      *********************
      *** Reset Counter ***
      *********************

           MOVE 0 TO counter.

      *    DISPLAY "<h3>" the-query " vs " the-pattern "</h3>".

           PERFORM VARYING counter FROM 1 BY 1
           UNTIL counter > 99 OR result = "n"

      *** for filling only entered values ***

      *    IF (chopped-path-piece(counter) EQUAL SPACES AND counter>1)
      *        DISPLAY "break"
      *        EXIT PERFORM
      *    ELSE
      *        DISPLAY counter "::" result 
      *                " (" chopped-path-piece(counter) 
      *                "/" chopped-pattern-piece(counter) ")<P>"
           
           IF (chopped-pattern-piece(counter)(1:1) EQUAL "%")

               ADD 1 TO counter-of-values
               
               MOVE chopped-pattern-piece(counter)
               TO query-value-name(counter-of-values) 
               
               MOVE chopped-path-piece(counter)
               TO query-value(counter-of-values)

      *        DISPLAY "got val " chopped-pattern-piece(counter) "<P>"

           END-IF    
           
           IF (chopped-path-piece(counter) NOT EQUAL
               chopped-pattern-piece(counter) AND 
               chopped-pattern-piece(counter)(1:1) NOT EQUAL "%")
                
               MOVE "n" TO result
      *        DISPLAY "<P><b>fail at " counter 
      *                "</b> (" chopped-path-piece(counter) 
      *                " :: "  chopped-pattern-piece(counter) ")</p>"
                
           END-IF

      *    END-IF

           END-PERFORM.

      ***********************************
      *** Check to result es positive ***
      ***********************************
           IF (result="y") 
               MOVE query-analysis TO query-analysis-out
           END-IF
           
           GOBACK.
