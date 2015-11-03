require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'parser'

class ParserTest < Minitest::Test

 # def test_intialize_takes_argument
 #   data = Parser.new(request_lines)
 #   #how to test
 #   #infinite loop? waiting for client response
 #   #having problems with line 8 
 # end

 def test_takes_argument
   parser = Parser.new(request_lines)
 end

 def test_get_verb
   parser = Parser.new(request_lines)
   assert_equal "GET", parser.get_verb
 end

 def test_get_path
   parser = Parser.new(request_lines)
   assert_equal "/", parser.get_path #getting favicon.ico
 end

 def test_get_protocol
   parser = Parser.new(request_lines)
   assert_equal "HTTP/1.1", parser.get_protocol
 end

 def test_get_host
   parser = Parser.new(request_lines)
   assert_equal "127.0.0.1", parser.get_verb
 end

 def test_get_port
   parser = Parser.new(request_lines)
   assert_equal "9292", parser.get_port
 end

 def test_get_origin
   parser = Parser.new(request_lines)
   assert_equal "HTTP/1.1", parser.get_protocol
 end

 def test_get_accept
   parser = Parser.new(request_lines)
   assert_equal "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,​*/*​;q=0.8, parser.get_protocol", parser.get_accept
 end

end
