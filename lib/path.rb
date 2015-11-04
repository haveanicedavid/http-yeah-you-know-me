require 'pry'

require_relative 'parser'
require_relative 'http_server'

class Path

  attr_reader :datetime

  def initialize(hash)
    @hash = hash
    parse = Parse.new(request_lines)
    @datetime = Time.new.strftime('%l:%M%p on %A, %B %-d %Y')
  end

  def path_response
    case 
    when hash[:Path] == '/'
      path_response = parse.formatted_parse
    when hash[:Path] == '/hello'
      path_response = "Hello World! (#{counter})"
    when hash[:Path] == '/datetime'
      path_response = @datetime
    when hash[:Path] == '/shutdown'
      path_response = "Total Request 12"
    end
  end 
end 


