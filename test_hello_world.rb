require 'socket'
require 'pry'

class HttpYeahYouKnowMe
  attr_accessor :port, :app, :server

  def initialize(port, app)
    @port = port
    @app = app
    @server = TCPServer.new(port)
  end

  def start
    until server.closed? do
      client = server.accept
      parse_request(client)
    end
  end

  def parse_request(client)
    first_line = client.gets.split(" ")
    env_hash = {}
    env_hash["REQUEST_METHOD"] = first_line[0]
    env_hash["PATH_INFO"] = first_line[1]
    env_hash["VERSION"] = first_line[2]
    form_headers(client, env_hash)
  end

  def form_headers(client, env_hash)
    headers = {}
    client.each_line do |data|
      break if data == "\r\n"
      key, value = data.split(': ')
      headers[key] = value
    end
    response(env_hash, client)
  end

  def response(env_hash, client)
    response = app.call(env_hash)
    client.print("HTTP/1.1 #{response[0]} OK\r\n")
    response[1].each { |header, value| client.print "#{header}: #{value}\r\n" }
    client.print("\r\n")
    client.print response[2][0]
    client.close
  end

  def stop
    server.close_read
    server.close_write
  end
end
