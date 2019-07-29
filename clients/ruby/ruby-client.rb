require 'net/http'

http = Net::HTTP.new('127.0.0.1', '5858')
request = Net::HTTP::Post.new('/')
request.body = 'hi'
response = http.request(request)
print response.body