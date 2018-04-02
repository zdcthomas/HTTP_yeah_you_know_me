require 'pry'
require_relative '../lib/parser'
require "Minitest/autorun"
require "Minitest/pride"

class ParserTest < MiniTest::Test
  def setup
    @env_hash = ["GET / HTTP/1.1",
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

  def test_parser_returns_correct_verb

    parser = Parser.new
    parser.format_lines(@env_hash)
    assert_equal "GET", parser.env["Verb"]
  end

  def test_parser_returns_correct_protocol

    parser = Parser.new
    parser.format_lines(@env_hash)
    assert_equal "HTTP/1.1", parser.env["Protocol"]
  end

  def test_parser_returns_correct_host

    parser = Parser.new
    parser.format_lines(@env_hash)
    assert_equal " localhost", parser.env["Host"]
  end

  def test_parser_returns_correct_path
    parser = Parser.new
    parser.format_lines(@env_hash)
    assert_equal "/", parser.env["Path"]
  end

  def test_parser_returns_correct_port
    parser = Parser.new
    parser.format_lines(@env_hash)
    assert_equal "9292", parser.env["Port"]
  end

  def test_parser_returns_correct_origin
    skip
    parser = Parser.new
    parser.format_lines(@env_hash)
    assert_equal "localhost", parser.env["Origin"]
  end

  def test_parser_returns_acceptance_type_correctly
    parser = Parser.new
    parser.format_lines(@env_hash)
    assert_equal "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8", parser.env["Accepts"]
  end

end
