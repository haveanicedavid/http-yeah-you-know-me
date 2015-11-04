require 'pry'

require_relative 'parser'
require_relative 'http_server'

class Path

  attr_reader :datetime

  def initialize(hash)
    @hash = hash
    parse = Parser.new(request_lines)
    @datetime = Time.new.strftime('%l:%M%p on %A, %B %-d %Y')
  end

  def path_response
    case 
    when hash[:Path] == '/'
      path_response = parse.formatted_parse #from Parse class
    when hash[:Path] == '/hello'
      path_response = "Hello World! (#{counter})"  #counter from http_server class
    when hash[:Path] == '/datetime'
      path_response = @datetime   #instantiated above
    when hash[:Path] == '/shutdown'
      path_response = "Total Request 12"
    end
    return path_response
  end 
end 


