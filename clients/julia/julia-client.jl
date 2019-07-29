using HTTP
using JSON

r = HTTP.request("POST", "http://127.0.0.1:5858", [], "Range[3]" )
println(r.status)
println( JSON.parse( String(r.body)))