require 'socket'
require_relative 'parser'
# require_relative 'word_search'
require 'pry'

server = TCPServer.new(9292)
counter = 0
hello_count = 0 

loop do 
client = server.accept
puts "Ready for a request"
request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

unless request_lines[0] == "GET /favicon.ico HTTP/1.1"
counter +=1
end 

parser = Parser.new(request_lines)
debug_info = parser.parse_debug
datetime = parser.datetime
# word_search = parser.word_search
# searcher = WordSeach.new
# word_search = searcher.search

puts "Got this request:"
puts request_lines.inspect


    case 
    #when debug_info[:Path] == "/word_search"
      #path_response = searcher.search
    when debug_info[:Path] == "/"
      path_response = parser.formatted_debug
    when debug_info[:Path] == "/hello"
      hello_count += 1
      path_response = "Hello World! (#{hello_count})"  
    when debug_info[:Path] == "/datetime"
      path_response = datetime 
    when debug_info[:Path] == "/shutdown"
      path_response = "Total Requests (#{counter})" 
      #client.close
    end

puts "Sending response."
output = "<html><head></head><body>#{path_response}</body></html>"
client.puts output
if output.include?("Total Requests")
  break 
end 
client.close

end
