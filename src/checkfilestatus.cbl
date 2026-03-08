      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. checkfilestatus.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       77 status-message  PIC X(72).
       77 display-message PIC X(72) VALUE SPACES.

       LINKAGE SECTION.
       77 file-name   PIC X(64).
       77 file-status PIC X(2).

       PROCEDURE DIVISION USING file-name file-status.

       start-checkfilestatus.
           
           IF file-status = '00'
               GOBACK
           END-IF

           EVALUATE file-status
           WHEN 00 MOVE 'SUCCESS.'               TO status-message   
           WHEN 02 MOVE 'SUCCESS DUPLICATE.'     TO status-message 
           WHEN 04 MOVE 'SUCCESS INCOMPLETE.'    TO status-message 
           WHEN 05 MOVE 'SUCCESS OPTIONAL.'      TO status-message 
           WHEN 07 MOVE 'SUCCESS NO UNIT.'       TO status-message 
           WHEN 10 MOVE 'END OF FILE.'           TO status-message 
           WHEN 14 MOVE 'OUT OF KEY RANGE.'      TO status-message 
           WHEN 21 MOVE 'KEY INVALID.'           TO status-message 
           WHEN 22 MOVE 'KEY EXISTS.'            TO status-message 
           WHEN 23 MOVE 'KEY NOT EXISTS.'        TO status-message 
           WHEN 30 MOVE 'PERMANENT ERROR.'       TO status-message 
           WHEN 31 MOVE 'INCONSISTENT FILENAME.' TO status-message 
           WHEN 34 MOVE 'BOUNDARY VIOLATION.'    TO status-message 
           WHEN 35 MOVE 'FILE NOT FOUND.'        TO status-message 
           WHEN 37 MOVE 'PERMISSION DENIED.'     TO status-message 
           WHEN 38 MOVE 'CLOSED WITH LOCK.'      TO status-message 
           WHEN 39 MOVE 'CONFLICT ATTRIBUTE.'    TO status-message 
           WHEN 41 MOVE 'ALREADY OPEN.'          TO status-message 
           WHEN 42 MOVE 'NOT OPEN.'              TO status-message 
           WHEN 43 MOVE 'READ NOT DONE.'         TO status-message 
           WHEN 44 MOVE 'RECORD OVERFLOW.'       TO status-message 
           WHEN 46 MOVE 'READ ERROR.'            TO status-message 
           WHEN 47 MOVE 'INPUT DENIED.'          TO status-message 
           WHEN 48 MOVE 'OUTPUT DENIED.'         TO status-message 
           WHEN 49 MOVE 'I/O DENIED.'            TO status-message 
           WHEN 51 MOVE 'RECORD LOCKED.'         TO status-message 
           WHEN 52 MOVE 'END-OF-PAGE.'           TO status-message 
           WHEN 57 MOVE 'I/O LINAGE.'            TO status-message 
           WHEN 61 MOVE 'FILE SHARING FAILURE.'  TO status-message 
           WHEN 91 MOVE 'FILE NOT AVAILABLE.'    TO status-message    
           END-EVALUATE

           STRING 'ERROR ' DELIMITED BY SIZE
           file-name       DELIMITED BY SPACE
           SPACE           DELIMITED BY SIZE
           status-message  DELIMITED BY '.'
           INTO display-message
           END-STRING
          
           DISPLAY display-message.
          
           STOP RUN.
