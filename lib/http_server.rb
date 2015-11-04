require 'socket'
require_relative 'parser'
# require_relative 'word_search'
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
parser = Parser.new(request_lines)
debug_info = parser.parse_debug
datetime = parser.datetime
# word_search = parser.word_search
# datetime = Time.new.strftime('%l:%M%p on %A, %B %-d %Y')
# searcher = WordSeach.new
# word_search = searcher.search

puts "Got this request:"
puts request_lines.inspect

    case 
    # when debug_info[:Verb] == "GET" && debug_info[:Path] == "/word_search"
      # path_response = searcher.search
    when debug_info[:Path] == "/"
      path_response = parser.formatted_debug
    when debug_info[:Path] == "/hello"
      path_response = "Hello World! (#{counter})"  
    when debug_info[:Path] == "/datetime"
      path_response = datetime 
    when debug_info[:Path] == "/shutdown"
      path_response = "Total Requests (#{counter})"
      client.close
    end

puts "Sending response."
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
