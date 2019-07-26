Print @ "Wolfram Expression Server 1.0";
Print @ "Server Usage: wolframserver.wls [port]";
Print @ "";
Print @ "Clients make a HTTP POST requests where the BODY data contains the Wolfram Language expression";
Print @ "Server returns ExpressionJSON data of the evaluated expression";

If[ Length[$ScriptCommandLine] == 2, port = ToExpression @ Part[$ScriptCommandLine,2], port = Automatic ];

Print[];
Print["Port: ", port];
Print["$ProcessID: ", $ProcessID];

ApacheDateString[] := With[{tz = StringReplace[DateString["ISOTimeZone"], ":" -> ""]}, 
 DateString[{"[", "Day", "/", "Month", "/", "Year", ":", "Hour", ":", 
   "Minute", ":", "Second", " ", tz, "]"}]];

ApacheLog[ str_String ] := Module[{}, Print[ "127.0.0.1 - - " <> ApacheDateString[] <> " \"POST / HTTP/1.1\" 200 " <> StringTrim[str] ] ];

listener = SocketListen[
  port,
  Function[{assoc},
   With[{
     client = assoc["SourceSocket"],
     data = assoc["Data"]
     },
    request = ImportString[data, "HTTPRequest"];
    result = ExportString[ ToExpression[ request["Body"], StandardForm ], "ExpressionJSON" ];
    response = 
     ExportString[
      HTTPResponse[
       result, <|"StatusCode" -> 200, 
        "ContentType" -> "application/json"|>], "HTTPResponse"];
    WriteString[client, response];
	ApacheLog[ request["Body"] ];
    Close[client]
    ]
   ]
  ];

url = URLBuild[<|"Scheme" -> "http", "Domain" -> First[listener["Socket"]["DestinationIPAddress"]], "Port" -> listener["Socket"]["DestinationPort"]|>];

task = First @ AsynchronousTasks[];

Print["Ready & Listening on: ", url, "\n"];
WaitAsynchronousTask[task]; 
