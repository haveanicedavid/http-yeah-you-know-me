require 'pry'

class Parser
  
  attr_reader :request_lines, :datetime
  
  def initialize(request_lines)
    @request_lines = request_lines
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

  def word_search
    
  end 

end 