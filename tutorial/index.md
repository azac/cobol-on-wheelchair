# Tutorial

Who says you can't teach a [54-year-old dog](http://www.amazon.com:80/Sams-Teach-Yourself-COBOL-Hours/dp/0672314533) some new tricks? ;)

_COBOL on Wheelchair_ is a minimal webframework\^H\^H\^H\^H\^H\^H just a proof of concept. However, it partially works, and it can handle:

- routing;
- PATH variables (GET and POST on the way...);
- basic templating.

In order to run _COBOL on Wheelchair_ you will need:

- some http server;
- [GNU COBOL](https://sourceforge.net/projects/open-cobol/) [`sudo apt-get install open-cobol];
- ability to run cgi-bin.

## Installation

1. Download

```
    git clone https://github.com/azac/cobol-on-wheelchair
```

2. Configure URL rewriting

_COBOL on Wheelchair_ comes with `.htaccess` file for Apache. If you're on Linux and all goes well, you shoudn't need to worry about that.

```
DirectoryIndex the.cow
	Options +ExecCGI
	AddHandler cgi-script .cow
	RewriteEngine on
	RewriteCond %{REQUEST_FILENAME} !-d
	RewriteCond %{REQUEST_FILENAME} !-f
	RewriteRule   ^(.*)$  the.cow/$1 [L]
```

3. Compile attached example

```
    ./downhill.sh
```

4. Enjoy

Point your browser to the appropriate URL. If all goes well, you should see your "Hello world":

@TODO: add the image.

## So how this works?

The directory structure:

```
	/controllers    <- here lives COBOL logic
	/views          <- here live web templates

	config.cbl      <- config file, defines routing
	cow.cbl         <- CoW before compilation
	downhill.sh     <- compilation script
	the.cow         <- CoW after compilation
```

### Routing

Routing is set in config.cbl file, using two tables. One (_routing-pattern_) holds paths, the other (_routing-destiny_) - names of attached controllers (COBOL subprograms). The following code:

```
       move "/example/path"        to routing-pattern(1).
       move "myroutine1"           to routing-destiny(1).
```

stands for 'send users visiting `server.com/example/path` to "myroutine1" controller'.

You can also accept variables from the path:

```
       move "/one/%value"          to routing-pattern(2).
       move "myroutine2"           to routing-destiny(2).

       move "/two/%val1/%val2"     to routing-pattern(3).
       move "myroutine3"           to routing-destiny(3).
```

You can set up to 99 routes.

### Controllers

Each route has a separate controller, that holds COBOL logic. They are located in `/controllers` directory.

Basic controller looks like that:

```

    identification division.
    program-id. routine1.

    data division.
    working-storage section.

    linkage section.

    01 the-values.
        05 COW-query-values           occurs 10 times.
           10 COW-query-value-name     pic x(90).
           10 COW-query-value          pic x(90).

    procedure division using the-values.

        display "Hello world".
        goback.

    end program routine1.
```

*the-values* hold information about variables received. At the moment, these come from PATH (GET and POST are on the way). You can access them in the same order they occur in path.

For instance, inside the "myroutine3" controller, defined in `config.cbl` with:

```
	move "/two/%val1/%val2"     to routing-pattern(3).
	move "myroutine3"           to routing-destiny(3).
```

You can access variables %val1 and %val2 by respective indices of *COW-query-value* table:

```
	display "%val1 is: " COW-query-value(1).
	display "%val2 is: " COW-query-value(2).
```

### Templating

Templates are located in `/views` directory. Nothing fancy here, simply put variable {{identifiers}} where they should show up:

```

    <html>
        <head>
            <title>
                Hello World!
            </title>
        </head>
        <body>

            Hello {{username}}, nice to meet you!

        </body>
    </html>
```

In order to use the template, you need to prepare variables and call templating engine from the controller. Below is the example of a controller utilizing Hello World template above.

```

    identification division.
    program-id. helloworld.

    data division.
    working-storage section.

    01 the-vars.
        03 COW-vars OCCURS 99 times.
           05 COW-varname       pic x(99).
           05 COW-varvalue      pic x(99).

    linkage section.

    01 the-values.
        05 COW-query-values           occurs 10 times.
           10 COW-query-value-name     pic x(90).
           10 COW-query-value          pic x(90).


    procedure division using the-values.

        move "username" to COW-varname(1).
        move COW-query-value(1) to COW-varvalue(1).

        call 'cowtemplate' using the-vars "hello.cow".

    goback.
    end program helloworld.
```

The new part is *the-vars* defined in the working-storage section. They will be utilized by the templating engine.

*the-vars* consists of two tables:

- _COW-varname_ - holding variable identifiers for templates;
- _COW-varvalue_ - holding respective values.

Assuming you want to inform the templating engine that `{{username}}` should equal "Edsger Dijkstra", you simply:

```
    move "username" to COW-varname(1).
    move "Edsger Dijkstra" to COW-varvalue(1).
```

When the templating variables are ready, we can invoke the 'cowtemplate' routine. First argument identifies the templating variables, second informs which template file should be used:

```
    call 'cowtemplate' using the-vars "hello.cow".
```

In the helloworld example above {{username}} is set to COW-query-value(1). As the result controller will inject the value received from the PATH into the template.

```
	myserver.com/hello/Edsger
```

will therefore produce:

```
	Hello Edsger, nice to meet you!
```

## Is it safe?

Of course not! I hacked this together over one night, and without any real knowledge of the language. I suppose the code is utterly horrible.

Btw, you should probably delete all .cbl files after final compilation.

## Why?

Why not?:)

## Questions?

email: adrian.zandberg@gmail.com
