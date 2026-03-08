      **************************************
      *** Author:  Azac                  ***
      *** License: MIT                   ***
      *** Date:    DECEMBER 21 FROM 2013 ***
      *** UPDATE:  AGUST 11 FROM 2022    ***
      **************************************
      
       IDENTIFICATION DIVISION.
       PROGRAM-ID. getquery.

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT webinput ASSIGN TO keyboard.


       DATA DIVISION.
       FILE SECTION.
       FD webinput.
          77 postchunk PIC X(1024).

       WORKING-STORAGE SECTION.

       78 name-count      VALUE 34.
       77 name-index      PIC 9(2) USAGE COMP-5.
       77 value-string    PIC X(256).
       
       01 environment-names.
          02 name-strings.
             03 filler    PIC X(20) VALUE 'AUTH_TYPE'.
             03 filler    PIC X(20) VALUE 'CONTENT_LENGTH'.
             03 filler    PIC X(20) VALUE 'CONTENT_TYPE'.
             03 filler    PIC X(20) VALUE 'DOCUMENT_ROOT'.
             03 filler    PIC X(20) VALUE 'GATEWAY_INTERFACE'.
             03 filler    PIC X(20) VALUE 'HTTP_ACCEPT'.
             03 filler    PIC X(20) VALUE 'HTTP_ACCEPT_CHARSET'.
             03 filler    PIC X(20) VALUE 'HTTP_ACCEPT_ENCODING'.
             03 filler    PIC X(20) VALUE 'HTTP_ACCEPT_LANGUAGE'.
             03 filler    PIC X(20) VALUE 'HTTP_COOKIE'.
             03 filler    PIC X(20) VALUE 'HTTP_CONNECTION'.
             03 filler    PIC X(20) VALUE 'HTTP_HOST'.
             03 filler    PIC X(20) VALUE 'HTTP_REFERER'.
             03 filler    PIC X(20) VALUE 'HTTP_USER_AGENT'.
             03 filler    PIC X(20) VALUE 'LIB_PATH'.
             03 filler    PIC X(20) VALUE 'PATH'.
             03 filler    PIC X(20) VALUE 'PATH_INFO'.
             03 filler    PIC X(20) VALUE 'PATH_TRANSLATED'.
             03 filler    PIC X(20) VALUE 'QUERY_STRING'.
             03 filler    PIC X(20) VALUE 'REMOTE_ADDR'.
             03 filler    PIC X(20) VALUE 'REMOTE_HOST'.
             03 filler    PIC X(20) VALUE 'REMOTE_IDENT'.
             03 filler    PIC X(20) VALUE 'REMOTE_PORT'.
             03 filler    PIC X(20) VALUE 'REQUEST_METHOD'.
             03 filler    PIC X(20) VALUE 'REQUEST_URI'.
             03 filler    PIC X(20) VALUE 'SCRIPT_FILENAME'.
             03 filler    PIC X(20) VALUE 'SCRIPT_NAME'.
             03 filler    PIC X(20) VALUE 'SERVER_ADDR'.
             03 filler    PIC X(20) VALUE 'SERVER_ADMIN'.
             03 filler    PIC X(20) VALUE 'SERVER_NAME'.
             03 filler    PIC X(20) VALUE 'SERVER_PORT'.
             03 filler    PIC X(20) VALUE 'SERVER_PROTOCOL'.
             03 filler    PIC X(20) VALUE 'SERVER_SIGNATURE'.
             03 filler    PIC X(20) VALUE 'SERVER_SOFTWARE'.
          
          02 filler REDEFINES name-strings.
             03 name-string PIC X(20) OCCURS name-count TIMES.



       LINKAGE SECTION.
       77 the-query PIC X(1600).  

       PROCEDURE DIVISION USING the-query.

           PERFORM VARYING name-index FROM 1 BY 1
           UNTIL name-index > name-count
                
                ACCEPT value-string FROM ENVIRONMENT
                    name-string(name-index)
                END-ACCEPT

                IF (name-string(name-index) = "PATH_INFO")
                    MOVE value-string TO the-query
                END-IF

         END-PERFORM.

      
       GOBACK.
