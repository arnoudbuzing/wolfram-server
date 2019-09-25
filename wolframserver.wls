#!/usr/bin/env wolframscript
Print @ "Wolfram Expression Server 0.0.1 (alpha)";
Print @ "Usage: wolframserver.wls [port]\n";

If[ Length[$ScriptCommandLine] == 2, port = ToExpression @ Part[$ScriptCommandLine,2], port = 5858 ];

Print["Port:       ", port];
Print["$ProcessID: ", $ProcessID];

ApacheDateString[] := With[{tz = StringReplace[DateString["ISOTimeZone"], ":" -> ""]},
  DateString[{"[", "Day", "/", "Month", "/", "Year", ":", "Hour", ":", "Minute", ":", "Second", " ", tz, "]"}]];

ApacheLog[ str_String ] := Module[{}, Print[ "127.0.0.1 - - " <> ApacheDateString[] <> " \"POST / HTTP/1.1\" 200 " <> StringTrim[str] ] ];

listener = SocketListen[
  port,
  Function[{assoc},
    With[{
      client = assoc["SourceSocket"],
      data = assoc["Data"]
    },
    request = ImportString[data, "HTTPRequest"];
    origin = Association[ request["Headers"] ]["origin"];
    result = ExportString[ ToExpression[ request["Body"], StandardForm ], "ExpressionJSON" ];
    response = ExportString[
      HTTPResponse[ result, <|
        "StatusCode" -> 200,
        "ContentType" -> "application/json",
        "Headers" -> { "Access-Control-Allow-Origin" -> origin }
      |>], "HTTPResponse"];
    WriteString[client, response];
    ApacheLog[ request["Body"] ];
    Pause @ 4;
    Close[client]
    ]
   ]
  ];

url = URLBuild[<|"Scheme" -> "http", "Domain" -> First[listener["Socket"]["DestinationIPAddress"]], "Port" -> listener["Socket"]["DestinationPort"]|>];

Print["Listening:  ", url, "\n"];

task = ZeroMQLink`Private`$AsyncState["Task"]; (* undocumented way to get at the async task of the socket listener *)
WaitAsynchronousTask[task];

