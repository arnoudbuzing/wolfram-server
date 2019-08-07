# wolfram-server

JSON based Wolfram Language expression evaluation server

#### Usage notes

The server accepts HTTP POST requests, where the body data consists of Wolfram Language code.
It takes this code, as a string, and evaluates it. Finally it converts the evaluated expression
to [ExpressionJSON](https://reference.wolfram.com/language/ref/format/ExpressionJSON.html) and
sends this JSON expression back to the client making the request.

#### Starting the Wolfram Language server

General usage:

```
wolframserver.wls [port]
```

If `port` is omitted a random (available) port is automatically selected.

Example, launch the server on port 5858:

```
wolframserver.wls 5858
```

#### Connecting to the server

Examples of language specific clients are in the `clients` directory.

##### Using curl

```
> curl -d "DateString[]" -X POST http://127.0.0.1:5858
"'Fri 26 Jul 2019 14:33:28'"
```

##### Using wget

```
> wget -qO- --post-data="DateString[]" http://127.0.0.1:5858
"'Fri 26 Jul 2019 14:25:56'"
```

##### Using Wolfram Language

```
> wolfram-client.wls "DateString[]"
"'Fri 26 Jul 2019 14:45:41'"
```

##### Using Go

Directly:

```
> go run go-client.go "DateString[]"
URL:> http://127.0.0.1:5858
response Status: 200 OK
response Headers: map[Content-Type:[application/json]]
response Body: "'Fri 26 Jul 2019 14:32:25'"

```

With compilation:

```
> go build go-client.go
> go-client.exe "DateString[]"
URL:> http://127.0.0.1:5858
response Status: 200 OK
response Headers: map[Content-Type:[application/json]]
response Body: "'Fri 26 Jul 2019 14:31:41'"

```

##### Using Python

```
> python-client.py "DateString[]"
result: "'Fri 26 Jul 2019 14:30:43'"
```

#### Using R

```
library(httr)
r <- POST('http://127.0.0.1:5858', body = 'DateString[]' )
print(content(r))
```

##### Using NodeJS

```
> node node-client.js "DateString[]"
statusCode: 200
"'Fri 26 Jul 2019 14:31:09'"
```

##### Using Windows PowerShell

```
> (Invoke-WebRequest -Method POST -Body "DateString[]" -Uri http://127.0.0.1:5858).Content
"'Fri 26 Jul 2019 14:36:47'"
```
