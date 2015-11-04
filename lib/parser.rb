require 'pry'

class Parse
  attr_reader :request_lines
  def initialize(request_lines)
    @request_lines = request_lines
  end
  
  def parse
    diagnostics = {}
    diagnostics[:Verb] = request_lines[0].split[0]
    diagnostics[:Path] = request_lines[0].split[1]
    diagnostics[:Protocol] = request_lines[0].split[2]
    diagnostics[:Host] = request_lines[1].split[1][1..-6]
    diagnostics[:Port] = request_lines[1].split[1][-4..-1]
    diagnostics[:Accept] = request_lines[3].split[1..-1]
    return diagnostics
  end 

  def formatted_parse
    parser = parse
    debug = parser.map do |key, value|
      "#{key}: #{value}\n"
    end
    debug.join
  end
end 