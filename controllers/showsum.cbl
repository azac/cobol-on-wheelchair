

       identification division.
       program-id. showsum.

       data division.
       working-storage section.

       01 sum-result pic z(36).

       01 the-vars.

          03  COW-vars OCCURS 99 times.
        
            05 COW-varname       pic x(99).
            05 COW-varvalue      pic x(99).    

       linkage section.

       01 received-values.

          05 query-values           occurs 10 times.
            10 query-value-name     pic x(90).
            10 query-value          pic x(90).


       procedure division using received-values.


           COMPUTE sum-result = 
              function numval(query-value(1)) 
                 + 
              function numval(query-value(2)).


           MOVE "number1" to COW-varname(1).
           MOVE query-value(1) to COW-varvalue(1).   
           MOVE "number2" to COW-varname(2).
           MOVE query-value(2) to COW-varvalue(2).
           MOVE "number3" to COW-varname(3).

           MOVE function trim(sum-result) to COW-varvalue(3).


           call 'template' using the-vars "showsum.cow".

      
       goback.

       end program showsum.