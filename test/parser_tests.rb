require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require 'minitest'

class ParserTest < Minitest::Test

  attr_reader :request_lines

  def setup
    @request_lines = 
    ["GET /word_search?word=badger&word=buckybadger HTTP/1.1", "Host: 127.0.0.1:9292",
    "Connection: keep-alive", "Cache-Control: no-cache",
    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) 
    AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
    "Postman-Token: a05d8814-1cb6-3fa4-385e-fde60c55d060", "Accept: */*",
    "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
  end 

 def test_verb
    parser = Parser.new(request_lines)
    assert_equal 'GET', parser.parsed_request[:Verb]
 end

 def test_path
    parser = Parser.new(request_lines)
    assert_equal '/word_search?word=badger&word=buckybadger', parser.parsed_request[:Path]
 end

 def test_protocol
    parser = Parser.new(request_lines)
    assert_equal 'HTTP/1.1', parser.parsed_request[:Protocol]
 end

 def test_host
    parser = Parser.new(request_lines)
    assert_equal '127.0.0.1', parser.parsed_request[:Host]
 end

 def test_port
    parser = Parser.new(request_lines)
    assert_equal '9292', parser.parsed_request[:Port]
 end

 def test_accept
    parser = Parser.new(request_lines)
    assert_equal "Mozilla/5.0", parser.parsed_request[:Accept][0]
 end

 def test_formatted_request
    parser = Parser.new(request_lines)
    assert_equal "Verb:", parser.formatted_request.split[0]
 end 

 def test_word_search_split
    parser = Parser.new(request_lines)
    assert_equal ["badger", "buckybadger"], parser.word_search_split
 end 

 def test_word_search_response
    parser = Parser.new(request_lines)
    assert_equal ["badger is a known word", "buckybadger is not a known word"], parser.word_search_response
 end 

end




