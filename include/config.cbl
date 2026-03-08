           MOVE 3 TO nroutes.
           MOVE "/"                        TO routing-pattern(1).
           MOVE "indexweb"                 TO routing-destiny(1).
           MOVE "/showsum/%value1/%value2" TO routing-pattern(2).
           MOVE "showsum"                  TO routing-destiny(2).
           MOVE "/showname/%value"         TO routing-pattern(3).
           MOVE "showname"                 TO routing-destiny(3).
