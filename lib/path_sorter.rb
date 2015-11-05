# class PathSorter

#   attr_reader :request_info, :parser

#   def initialize(request_lines)
#     @parser = Parser.new(request_lines)
#     @request_info = @parser.parsed_request
#   end 

#   def sorted_response
#     if @request_info[:Path] == "/"
#         path_response = parser.formatted_debug
#       elsif @request_info[:Path] == "/hello"
#          hello_count += 1
#         path_response = "Hello World! (#{hello_count})"  
#       elsif @request_info[:Path] == "/datetime"
#         path_response = parser.datetime 
#       elsif @request_info[:Path] == "/shutdown"
#         path_response = "Total Requests (#{total_requests})" 
#       elsif @request_info[:Path].include?("/word")
#         path_response = parser.word_search_response
#     end
#   end
# end

