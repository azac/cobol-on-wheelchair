*> ***********************************************



       identification division.
       program-id. cowtemplate.

       environment division.
       input-output section.
       file-control.

           select readfile
               assign to readfile-name
               file status is readfile-status
               organization is line sequential.

       data division.
       file section.
       fd  readfile.
       01  readline pic x(1024).

       working-storage section.

       01  readfile-name pic x(255).
       01  readfile-status pic x(2).

       01  templine pic x(1024).

       01  the-var           pic x(100).
       01  what-we-change    pic x(100).

       01 counter    PIC 9(4).


       linkage section.

       01 the-vars.

          03  COW-vars OCCURS 99 times.
        
            05 COW-varname       pic x(99).
            05 COW-varvalue      pic x(99).

       01 template-filename     pic x(255).                 


       procedure division using the-vars template-filename.

       move 
          function concatenate("views/",function trim(template-filename))
          to readfile-name.

       start-readfile.

           open input readfile

           call 'checkfilestatus' using readfile-name readfile-status

           read readfile

           perform until readfile-status = '10'
           
           move function trim(readline) to templine
               
               PERFORM VARYING counter FROM 1 BY 1 UNTIL counter > 99

                   move 
                      function concatenate(
                        '{{' function trim(COW-varname(counter)) '}}'
                        )
                      to 
                      what-we-change

                   move
                      function SUBSTITUTE(
                        templine, 
                        function trim(what-we-change), 
                        function trim(COW-varvalue(counter)))
                       to templine 

               END-PERFORM

               display function trim(templine)


               read readfile
           end-perform

           close readfile.
           


       identification division.
       program-id. checkfilestatus.

       data division.
       working-storage section.
       01  status-message pic x(72).
       01  display-message pic x(72) value spaces.

       linkage section.
       01  file-name pic x(64).
       01  file-status pic x(2).

       procedure division using file-name file-status.
       start-checkfilestatus.
           if file-status = '00'
               goback
           end-if
           evaluate file-status
           when 00 move 'SUCCESS.' TO status-message   
           when 02 move 'SUCCESS DUPLICATE.' TO status-message 
           when 04 move 'SUCCESS INCOMPLETE.' TO status-message 
           when 05 move 'SUCCESS OPTIONAL.' TO status-message 
           when 07 move 'SUCCESS NO UNIT.' TO status-message 
           when 10 move 'END OF FILE.' TO status-message 
           when 14 move 'OUT OF KEY RANGE.' TO status-message 
           when 21 move 'KEY INVALID.' TO status-message 
           when 22 move 'KEY EXISTS.' TO status-message 
           when 23 move 'KEY NOT EXISTS.' TO status-message 
           when 30 move 'PERMANENT ERROR.' TO status-message 
           when 31 move 'INCONSISTENT FILENAME.' TO status-message 
           when 34 move 'BOUNDARY VIOLATION.' TO status-message 
           when 35 move 'FILE NOT FOUND.' TO status-message 
           when 37 move 'PERMISSION DENIED.' TO status-message 
           when 38 move 'CLOSED WITH LOCK.' TO status-message 
           when 39 move 'CONFLICT ATTRIBUTE.' TO status-message 
           when 41 move 'ALREADY OPEN.' TO status-message 
           when 42 move 'NOT OPEN.' TO status-message 
           when 43 move 'READ NOT DONE.' TO status-message 
           when 44 move 'RECORD OVERFLOW.' TO status-message 
           when 46 move 'READ ERROR.' TO status-message 
           when 47 move 'INPUT DENIED.' TO status-message 
           when 48 move 'OUTPUT DENIED.' TO status-message 
           when 49 move 'I/O DENIED.' TO status-message 
           when 51 move 'RECORD LOCKED.' TO status-message 
           when 52 move 'END-OF-PAGE.' TO status-message 
           when 57 move 'I/O LINAGE.' TO status-message 
           when 61 move 'FILE SHARING FAILURE.' TO status-message 
           when 91 move 'FILE NOT AVAILABLE.' TO status-message    
           end-evaluate
           string 'ERROR ' delimited by size
               file-name delimited by space
               space delimited by size
               status-message delimited by '.'
               into display-message
           display display-message
           stop run
           .
       end program checkfilestatus.
       end program cowtemplate.
