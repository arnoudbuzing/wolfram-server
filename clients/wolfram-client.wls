request = "http://127.0.0.1:5858" ~ HTTPRequest ~ <| Method -> "POST", "Body" -> Last[$ScriptCommandLine] |>;

response = URLRead @ request;

Print @ response @ "Body"

