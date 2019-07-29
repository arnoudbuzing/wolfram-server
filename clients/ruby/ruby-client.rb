# not yet working, somehow the body data 'hi' arrives before the http headers (?)

require 'net/http'

http = Net::HTTP.new('127.0.0.1', '5858')
http.set_debug_output($stdout)
request = Net::HTTP::Post.new('/')
request['Content-Type'] = 'text/plain'
request.body = 'hi'
response = http.request(request)
print response.body