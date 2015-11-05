require 'socket'
require_relative 'parser'
require 'pry'

server = TCPServer.new(9292)
total_requests = 0
hello_count = 0 

loop do 
  client = server.accept
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  unless request_lines[0] == "GET /favicon.ico HTTP/1.1"
    total_requests +=1

  parser = Parser.new(request_lines)
  debug_info = parser.parse_debug

  puts "Ready for a request"
  puts "Got this request:"
  puts request_lines.inspect

      case 
      when debug_info[:Path] = "/" then path_response = parser.formatted_debug
      when debug_info[:Path] = "/hello" then hello_count += 1 
        path_response = "Hello World! (#{hello_count})"  
      when debug_info[:Path] = "/datetime" then path_response = parser.datetime 
      when debug_info[:Path] = "/shutdown" then path_response = "Total Requests (#{total_requests})"
      when debug_info[:Path].start_with?("/word_search?") then path_response = parser.word_search_response
      end


  puts "Sending response."
  output = "<html><head></head><body>#{path_response}</body></html>"
  client.puts output
  if output.include?("Total Requests")
    break 
  end 
  end 
  client.close

end
