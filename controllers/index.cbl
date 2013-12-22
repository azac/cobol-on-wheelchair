

       identification division.
       program-id. indexweb.

       data division.
       working-storage section.

       01 the-vars.

          03  COW-vars OCCURS 99 times.
        
            05 COW-varname       pic x(99).
            05 COW-varvalue      pic x(99).    


       procedure division.

           call 'template' using the-vars "index.cow".

      
       goback.

       end program indexweb.

