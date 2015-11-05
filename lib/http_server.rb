require_relative 'parser'
require_relative 'game'
require 'socket'
require 'pry'

server         = TCPServer.new(9292)
total_requests = 0
hello_count    = 0
@game          = Game.new

loop do
  client        = server.accept
  request_lines = []
  request_body  = []

  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  ## NOTE
  ### I put the following in to acces the 'body' of the requeset. The request_lines array only stores information that would come from a requests' headers
  if request_lines.join.include?("Content-Type")
    while line = client.gets and !line.chomp.empty?
      request_body << line .chomp
    end
    request_body << client.gets
  end

  unless request_lines[0] == "GET /favicon.ico HTTP/1.1"
    total_requests +=1

    parser = Parser.new(request_lines)
    request_info = parser.parsed_request

  ## NOTE
    # Though you can't put conditionals in the 'when' segment of case statements, you can put extra conditionals in the final 'else' block of it. See line 54
    case request_info[:Path]
    when "/"
      path_response = parser.formatted_request
    when "/hello"
      hello_count += 1
      path_response = "Hello World! (#{hello_count})"
    when "/datetime"
      path_response = parser.datetime
    when "/start_game"
      path_response = "Good luck!"
    when "/game"
      if request_info[:Verb] == 'POST'
        user_guess = request_body[-1].to_i
        @game.guess(user_guess)
        ## NOTE
        # You'd have to do something here to redirect the client to /game with the verb GET. Not sure how
      end
      path_response = @game.status
    when "/shutdown"
      path_response = "Total Requests (#{total_requests})"
    else
      if request_info[:Path].include?("/word")
        path_response = parser.word_search_response
      end
    end

    output = "<html><head></head><body>#{path_response}</body></html>"
    client.puts output
      if output.include?("Total Requests")
        break
      end
  end
  client.close
end
