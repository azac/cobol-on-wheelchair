      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. cowtemplate.

       ENVIRONMENT DIVISION.
       
       INPUT-OUTPUT SECTION.
       
       FILE-CONTROL.

           SELECT readfile
               ASSIGN TO readfile-name
               FILE STATUS IS readfile-status
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.

       FD readfile.
       77 readline PIC X(1024).

       WORKING-STORAGE SECTION.

       77 readfile-name   PIC X(255).
       77 readfile-status PIC X(2).
       77 templine        PIC X(1024).
       77 the-var         PIC X(100).
       77 what-we-change  PIC X(100).
       77 counter         PIC 9(4).


       LINKAGE SECTION.

       01 the-vars.
          
          03 COW-vars OCCURS 99 TIMES.
            
            05 COW-varname  PIC X(99).
            05 COW-varvalue PIC X(99).

       77 template-filename PIC X(255).                 


       PROCEDURE DIVISION USING the-vars template-filename.

           MOVE 
               FUNCTION CONCATENATE("views/",
               FUNCTION TRIM(template-filename))
           TO readfile-name.

       start-readfile.

           OPEN INPUT readfile

           CALL 'checkfilestatus' USING readfile-name readfile-status

           READ readfile

           PERFORM UNTIL readfile-status = '10'
           
           MOVE FUNCTION TRIM(readline) TO templine
               
           PERFORM VARYING counter FROM 1 BY 1 UNTIL counter > 99

           MOVE
               FUNCTION CONCATENATE( '{{'
               FUNCTION TRIM(COW-varname(counter)) '}}')
           TO what-we-change

           MOVE
               FUNCTION SUBSTITUTE(templine, 
               FUNCTION TRIM(what-we-change), 
               FUNCTION TRIM(COW-varvalue(counter)))
           TO templine

           END-PERFORM

           DISPLAY FUNCTION TRIM(templine)
           READ readfile
           
           END-PERFORM

           CLOSE readfile.
