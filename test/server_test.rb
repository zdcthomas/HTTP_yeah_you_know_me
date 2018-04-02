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

  def test_server_can_connect
    response = Faraday.get('http://localhost:9292/')
    assert_equal 200, response.status
  end

  def test_server_can_receive_request
    skip
  end

  def test_server_can_return_hello_world
    skip
  end

  def test_server_can_track_previous_request
    skip
  end
end
