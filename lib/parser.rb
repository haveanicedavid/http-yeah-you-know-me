require 'pry'

class Parser
  
  attr_reader :request_lines, :datetime
  
  def initialize(request_lines)
    @request_lines = request_lines
    @dictionary = File.read("/usr/share/dict/words")
    @datetime = Time.new.strftime('%l:%M%p on %A, %B %-d %Y')
  end

  def parsed_request
     diagnostic = {
    :Verb => request_lines[0].split[0],
    :Path => request_lines[0].split[1],
    :Protocol => request_lines[0].split[2],
    :Host => request_lines[1].split[1][0..-6],
    :Port => request_lines[1].split[1][-4..-1],
    :Accept => request_lines[4].split[1..-1]
    }
  end 

  def formatted_request
    format = parsed_request.map do |key, value|
      "#{key}: #{value} \n "
    end
    format.join
  end
 
  def word_search_split 
    parameters = parsed_request[:Path].split("?")[1] 
    parameter_value = parameters.split("&") 
    parameter_value.map! do |combo| 
      combo.split("=")[1]
    end 
  end 

  def word_search_response
    response = word_search_split.map! do |value|
      if @dictionary.include?(value)
        "#{value} is a known word"
      else 
        "#{value} is not a known word"
      end 
    end
  end 
end 

