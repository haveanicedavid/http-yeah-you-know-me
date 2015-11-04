require 'socket'
require_relative 'parser'
require_relative 'path'
require 'pry'

tcp_server = TCPServer.new(9292)
counter = 0

loop do 
client = tcp_server.accept

puts "Ready for a request"
request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

counter +=1

puts "Got this request:"
puts request_lines.inspect

# parser = Parser.new(request_lines)   
# hash = parser.parse
# path = Path.new
# response = path.path_response

parser = Parser.new(request_lines)
hash = parser.parse
datetime = Time.new.strftime('%l:%M%p on %A, %B %-d %Y')

    case 
    when hash[:Path] == "/"
      path_response = parser.formatted_parse
    when hash[:Path] == "/hello"
      path_response = "Hello World! (#{counter})"  
    when hash[:Path] == "/datetime"
      path_response = datetime 
    when hash[:Path] == "/shutdown"
      path_response = "Total Requests (#{counter})"
      client.close
    end
  


puts "Sending response."
# response = "<pre>Hello World! (#{counter}) \n#{formatted_parse} </pre>"
# response = "<pre>#{selected_path} </pre>"
output = "<html><head></head><body> #{path_response}</body></html>"
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





# class HTTP

# attr_accessor :port  

# def initialize(port)
#  @port = port
#  @server = TCPServer.new(port)
# end 

# end

# # refresh_count = 0

# def start 
#  until server.closed? do 
#    client = server.accept
#    parse(client)
#  end 
# end 

# # request_lines = []
# # # while line = client.gets and !line.chomp.empty?
# # #  request_lines << line.chomp
# # # end
# # puts "Got this request:"
# # puts request_lines.inspect

# # def response

# # end 
# # puts "Sending response."
# # response = "<pre> Hello World! </pre>"
# # output = "<html><head></head><body>#{response}</body></html>"
# # headers = ["http/1.1 200 ok",
# #          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
# #          "server: ruby",
# #          "content-type: text/html; charset=iso-8859-1",
# #          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
# # def headers
# # end  

# # client.puts headers
# # client.puts output

# # # puts ["Wrote this response:", headers, output].join("\n")

#  def stop 
#  server.close
#  end

# end