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
  end 

  parser = Parser.new(request_lines)
  debug_info = parser.parse_debug
  datetime = parser.datetime

  puts "Got this request:"
  puts request_lines.inspect

      case 
      when debug_info[:Path] == "/"
        path_response = parser.formatted_debug
      when debug_info[:Path] == "/hello"
        hello_count += 1
        path_response = "Hello World! (#{hello_count})"  
      when debug_info[:Path] == "/datetime"
        path_response = datetime 
      when debug_info[:Path] == "/shutdown"
        path_response = "Total Requests (#{total_requests})"
      when debug_in 
      end
      # case debug_info[:Path]
      # when "/" then path_response = parser.formatted_debug

  puts "Sending response."
  output = "<html><head></head><body>#{path_response}</body></html>"
  client.puts output
  if output.include?("Total Requests")
    break 
  end 
  client.close

puts "Got this request:"
puts request_lines.inspect

#if the path == '/'
#respond with request lines from parse
#if the path == '/hello'
#respond with "Hello World! and the #{counter}"
#if the path == '/datetime'
#respond with 

puts "Sending response."
response = "<pre>Hello World! (#{counter})\n#{parse(request_lines)} </pre>"
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
