require 'pry'

class Parser
  
  attr_reader :request_lines, :datetime
  
  def initialize(request_lines)
    @request_lines = request_lines
    @dictionary = File.read("/usr/share/dict/words")
    @datetime = Time.new.strftime('%l:%M%p on %A, %B %-d %Y')
  end
  
  def parse_debug
    diagnostics = {}
    diagnostics[:Verb] = request_lines[0].split[0]
    diagnostics[:Path] = request_lines[0].split[1]
    diagnostics[:Protocol] = request_lines[0].split[2]
    diagnostics[:Host] = request_lines[1].split[1][1..-6]
    diagnostics[:Port] = request_lines[1].split[1][-4..-1]
    diagnostics[:Accept] = request_lines[3].split[1..-1]
    return diagnostics
  end 

  def formatted_debug
    parser = parse_debug
    debug = parser.map do |key, value|
      "#{key}: #{value}\n"
    end
    debug.join
  end
 
  def word_search_split
    data = parse_debug[:Path]
    post_path = data.split("?")[1]  #"word=cat&word=dog"
    word_then_value = post_path.split("&") #["word=cat", "word=dog"]
    word_then_value.map! do |combo| #[word, cat], [word, dog]
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
    response.to_s
  end 
end 

