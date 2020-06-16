STDOUT.sync = true

require 'socket'

def request(s)
  puts 'Receive request...'

  request = ''

  until (line = s.gets) == "\r\n"
    return if line.nil?
    request << line
  end

  puts request

  s.print "HTTP/1.1 200\r\n"
  s.print "Content-Type: text/plain\r\n"
  s.print "\r\n"
  s.print request
ensure
  s.close
end

puts 'Create server...'
server = TCPServer.new(ENV['PORT'])

puts 'Start accepting connections...'
loop do
  request(server.accept)
end
