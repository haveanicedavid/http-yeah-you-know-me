require 'socket'
require 'pry'

class HTTP

attr_accessor :port  

def initialize(port)
 @port = port
 @server = TCPServer.new(port)
end

# refresh_count = 0

def start 
 until server.closed? do 
   client = @server.accept
   parse(client)
 end 
end 

# request_lines = []
# # while line = client.gets and !line.chomp.empty?
# #  request_lines << line.chomp
# # end
# puts "Got this request:"
# puts request_lines.inspect

def parse(client)
  request_lines = Hash.new
  first_line

end



# def response

# end 
# puts "Sending response."
# response = "<pre> Hello World! </pre>"
# output = "<html><head></head><body>#{response}</body></html>"
# headers = ["http/1.1 200 ok",
#          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
#          "server: ruby",
#          "content-type: text/html; charset=iso-8859-1",
#          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
# def headers
# end  

# client.puts headers
# client.puts output

# # puts ["Wrote this response:", headers, output].join("\n")

 def stop 
 server.close
 end

end