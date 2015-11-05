require 'socket'
require_relative 'parser'
require_relative 'path_sorter'
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

  puts "Got this request:"
  puts request_lines.inspect
  #path_sorter = PathSorter.new(request_lines).sorted_response

  parser = Parser.new(request_lines)
  request_info = parser.parsed_request

      if request_info[:Path] == "/"
        path_response = parser.formatted_debug
      elsif request_info[:Path] == "/hello"
        hello_count += 1
        path_response = "Hello World! (#{hello_count})"  
      elsif request_info[:Path] == "/datetime"
        path_response = parser.datetime 
      elsif request_info[:Path] == "/shutdown"
        path_response = "Total Requests (#{total_requests})" 
      elsif request_info[:Path].include?("/word")
        path_response = parser.word_search_response
      end

  output = "<html><head></head><body>#{path_response}</body></html>"
  client.puts output
    if output.include?("Total Requests")
      break 
    end
  end 
  client.close
end
