require 'pry'
require 'socket'
require 'net/http'
require 'faraday'
require_relative '../lib/server'
require "Minitest/autorun"
require "Minitest/pride"

class ServerTest < MiniTest::Test
  def setup
    Thread.new do
      @server = Serv.new(9292)
    end
  end

  # tests skipped for rake file
  def test_it_exists
    skip
    assert_instance_of Serv, @server
  end

  # def test_begin_connection
  #   server = Serv.new(9292)
  #   assert_instance_of Socket, server.begin_connection
  #   server.terminate
  # end

  def test_server_can_connect
    skip
    response = Faraday.get('http://localhost:9292/')
    assert_equal 200, response.status
  end

end
