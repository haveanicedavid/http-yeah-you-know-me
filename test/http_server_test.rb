require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/http_server'

class HTTPTest < Minitest::Test

  def test_intiializes_with_argument
    h = HTTP.new(9292)
    assert_equal 9292, h.port
  end 

  def test_verb
    h = HTTP.new(9292)
    assert_equal "GET", h.parse
  end 


# ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/601.2.7 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.7", "Accept-Language: en-us", "Cache-Control: max-age=0", "Connection: keep-alive"]



 # def test_intialize_takes_argument
 #   data = Parser.new(request_lines)
 #   #how to test
 #   #infinite loop? waiting for client response
 #   #having problems with line 8 
 # end

 # def test_takes_argument
 #   parser = Parser.new(request_lines)
 # end

 # def test_get_verb
 #   parser = Parser.new(request_lines)
 #   assert_equal "GET", parser.get_verb
 # end

 # def test_get_path
 #   parser = Parser.new(request_lines)
 #   assert_equal "/", parser.get_path #getting favicon.ico
 # end

 # def test_get_protocol
 #   parser = Parser.new(request_lines)
 #   assert_equal "HTTP/1.1", parser.get_protocol
 # end

 # def test_get_host
 #   parser = Parser.new(request_lines)
 #   assert_equal "127.0.0.1", parser.get_verb
 # end

 # def test_get_port
 #   parser = Parser.new(request_lines)
 #   assert_equal "9292", parser.get_port
 # end

 # def test_get_origin
 #   parser = Parser.new(request_lines)
 #   assert_equal "HTTP/1.1", parser.get_protocol
 # end

 # def test_get_accept
 #   parser = Parser.new(request_lines)
 #   assert_equal "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,​*/*​;q=0.8, parser.get_protocol", parser.get_accept
 # end

end
