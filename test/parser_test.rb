require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'

class ParserTest < Minitest::Test 

  def test_verb_equals_value
    parser = Parser.new(request_lines)
    assert_equal "GET", parser.parsed_requests
  end 
  
end 
