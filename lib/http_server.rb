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
parser = Parser.new(request_lines)
hash = parser.parse
datetime = Time.new.strftime('%l:%M%p on %A, %B %-d %Y')

puts "Got this request:"
puts request_lines.inspect

#user inputs http address into url 
#server recovers and stores code
#make sure it enters as string
#split at the question mark
#take the 1st element of that split(the second half)
#split the second half at the & symbol
#take each element 
#iterate through all the elements and split at the = symbol
#take the first element or word fragment value
#reference that word fragment value to the dictionary
#if the word fragment value is in the dictionary
  #output "#{word fragment value} is a known word
#if the word fragment value is not in the dictionary
  #output "#{word fragment value} is NOT a known word"

    case 
    when hash[:Verb] == "GET" && hash[:Path] == "/"

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
