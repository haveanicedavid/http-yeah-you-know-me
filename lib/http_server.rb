class Parser

attr_reader :request_lines

def initialize(request_lines)
 @request_lines = request_lines
end  


def get_verb(string)
 string[0].split(" ")[0]
end

def format(request_lines)
 response = []
 response << "Verb: #{get_verb(request_lines)}"
 response << "Path: #{get_path(request_lines)}"
 response << "Protocol: #{get_protocol(request_lines)}"
 response << "Host: #{get_host(request_lines)}"
 response << "origin: #{get_origin(request_lines)}"
 response << "accept: #{get_accept(request_lines)}"
end
end

stevepentler [5:49 PM]
class Request

 def request_output

   tcp_server = TCPServer.new(9292)
   client = tcp_server.accept

   puts "Ready for a request"
   request_lines = []
   while line = client.gets and !line.chomp.empty?
     request_lines << line.chomp
   end

   puts "Got this request:"
   puts request_lines.inspect

 end 
end

stevepentler [5:49 PM]
class Response

 puts "Sending response."
 response = "<pre>" "Hello World! (#{0})" "</pre>"
 output = "<html><head></head><body>#{response}</body></html>"
 headers = ["http/1.1 200 ok",
           "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
           "server: ruby",
           "content-type: text/html; charset=iso-8859-1",
           "content-length: #{output.length}\r\n\r\n"].join("\r\n")
 client.puts headers
 client.puts output

 puts ["Wrote this response:", headers, output].join("\n")
 client.close
 puts "\nResponse complete, exiting."
 
end