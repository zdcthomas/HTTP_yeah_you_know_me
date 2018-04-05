require 'faraday'
require './lib/loop_server'

require "Minitest/autorun"
require "Minitest/pride"

class ServerLoopTest < MiniTest::Test
  # def setup
  #   @thr = Thread.new do
  #     loop = ServerLoop.new(9292)
  #     loop.start_loop
  #   end
  # end


  # def test_it_exists
  #   skip
  #   response = Faraday.get('http://localhost:9292/')
  #   assert_instance_of , response
  # end


  def test_server_returns_diagnostic_on_blank_path

    response = Faraday.get('http://localhost:9292/')
    assert response.body.include?("Port: 9292")
    assert response.body.include?("Host: localhost")
    assert response.body.include?("Verb: GET")
    assert response.body.include?("Path: /")
  end

  def test_server_returns_datetime

    response = Faraday.get('http://localhost:9292/datetime')
    expected = "<html><head></head><body>#{Time.now.strftime('%I:%M%p on %A, %B %d, %Y')}</body></html>"
    assert_equal expected, response.body
  end

  def test_server_can_connect

    response = Faraday.get('http://localhost:9292/')
    assert_equal 200, response.status
  end

  # skipped for rake test
  def test_server_returns_hello_world
    skip
    response = Faraday.get('http://localhost:9292/hello')
    expected = "<html><head></head><body>Hello World (0)</body></html>"
    assert_equal expected, response.body
    response = Faraday.get('http://localhost:9292/hello')
    expected = "<html><head></head><body>Hello World (1)</body></html>"
    assert_equal expected, response.body
    response = Faraday.get('http://localhost:9292/hello')
    expected = "<html><head></head><body>Hello World (2)</body></html>"
    assert_equal expected, response.body
  end

end
