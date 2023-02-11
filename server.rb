require 'socket'
require 'json'

PORT = 5999

server = TCPServer.new PORT

while session = server.accept
  path = session.gets.split(' ')[1].split('?').first
  status = path.split('/')[1]
  message = "Request for #{path}. Responding with #{status}"
  puts message
  response = {
    code: "HTTP_STATUS.CODE.#{status}",
    message: message,
    errors: [],
  }
  session.print "HTTP/1.1 #{status}\r\n"
  session.print "Content-Type: application/json\r\n"
  session.print "\r\n"
  session.print response.to_json
  session.print "\r\n"
  session.close
end
