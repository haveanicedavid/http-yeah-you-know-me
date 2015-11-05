require 'socket'
require_relative 'parser'
require 'pry'

server = TCPServer.new(9292)
total_requests = 0
hello_count = 0 

loop do 
  client = server.accept
  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  unless request_lines[0] == "GET /favicon.ico HTTP/1.1"
  total_requests +=1

  parser = Parser.new(request_lines)
  debug_info = parser.parse_debug

  puts "Got this request:"
  puts request_lines.inspect

      case 
      when debug_info[:Path] == "/"
        path_response = parser.formatted_debug
      when debug_info[:Path] == "/hello"
        hello_count += 1
        path_response = "Hello World! (#{hello_count})"  
      when debug_info[:Path] == "/datetime"
        path_response = parser.datetime 
      when debug_info[:Path] == "/shutdown"
        path_response = "Total Requests (#{total_requests})" 
      # when debug_info[:Path].start_with?("/word_search?")
      #   path_response = parser.word_search_response
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
