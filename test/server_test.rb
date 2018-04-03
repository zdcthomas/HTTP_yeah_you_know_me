require 'pry'
require 'socket'
require 'net/http'
require 'faraday'
require_relative '../lib/server'
require "Minitest/autorun"
require "Minitest/pride"

class ServerTest < MiniTest::Test
  def setup
  end
  def test_it_exists
    server = Serv.new(9292)
    assert_instance_of Serv, server
  end

  def test_begin_connection
    server = Serv.new(9292)

  end

  def test_it_can_receive_request_lines
  end

  def test_it_can_terminate
  end

  def test_server_can_connect
    response = Faraday.get('http://localhost:9292/')
    assert_equal 200, response.status
  end

end
