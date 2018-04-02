require 'pry'
require 'socket'
require 'net/http'
require 'faraday'
require_relative '../lib/server'
require "Minitest/autorun"
require "Minitest/pride"

class ServerTest < MiniTest::Test
  def setup
    @server = Serv.new(9292)
  end

  def test_server_can_connect
    @server.begin_connection
    response = Faraday.get('http://localhost:9292/')
    @server.receive_request_lines
    assert_equal 200, response.status
    # make some mock client, make sure it can send request, and receive standard output
  end

  def test_server_can_receive_request
  end

  def test_server_can_return_hello_world
  end

  def test_server_can_track_previous_request
  end
end
