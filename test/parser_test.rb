require 'pry'
require_relative '../lib/parser'
require "Minitest/autorun"
require "Minitest/pride"

class ParserTest < MiniTest::Test
  def setup
    @request_lines = ["GET / HTTP/1.1",
                      "Host: localhost:9292",
                      "Connection: keep-alive",
                      "Upgrade-Insecure-Requests: 1",
                      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                      "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                      "Accept-Encoding: gzip, deflate, br",
                      "Accept-Language: en-US,en;q=0.9"]
  end

  def test_it_exists
    parser = Parser.new
    assert_instance_of Parser, parser
  end

end 
