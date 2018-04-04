require 'pry'
require_relative '../lib/parser'
require "Minitest/autorun"
require "Minitest/pride"

class ParserTest < MiniTest::Test
  def setup
    @request = ["GET / HTTP/1.1",
                "Host: localhost:9292",
                "Connection: keep-alive",
                "Upgrade-Insecure-Requests: 1",
                "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                "Accept-Encoding: gzip, deflate, br",
                "Accept-Language: en-US,en;q=0.9"]
    @request_hello = ["GET /hello HTTP/1.1",
                "Host: localhost:9292",
                "Connection: keep-alive",
                "Upgrade-Insecure-Requests: 1",
                "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                "Accept-Encoding: gzip, deflate, br",
                "Accept-Language: en-US,en;q=0.9"]

    @request_param = ["GET /word_search?word=example HTTP/1.1",
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
    parser.format_lines(@request)
    assert_equal "GET", parser.env["Verb"]
  end

  def test_parser_returns_correct_protocol

    parser = Parser.new
    parser.format_lines(@request)
    assert_equal "HTTP/1.1", parser.env["Protocol"]
  end

  def test_parser_returns_correct_host

    parser = Parser.new
    parser.format_lines(@request)
    assert_equal " localhost", parser.env["Host"]
  end

  def test_parser_returns_correct_path
    parser = Parser.new
    parser.format_lines(@request)
    assert_equal "/", parser.env["Path"]
  end

  def test_parser_returns_correct_path_hello
    parser = Parser.new
    parser.format_lines(@request_hello)
    assert_equal "/hello", parser.env["Path"]
  end

  def test_parser_returns_correct_port
    parser = Parser.new
    parser.format_lines(@request)
    assert_equal "9292", parser.env["Port"]
  end

  def test_parser_returns_correct_origin
    skip
    parser = Parser.new
    parser.format_lines(@request)
    assert_equal "localhost", parser.env["Origin"]
  end

  def test_parser_returns_acceptance_type_correctly
    parser = Parser.new
    parser.format_lines(@request)
    assert_equal "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8", parser.env["Accepts"]
  end

  def test_it_returns_accurate_diagnostic_verb
    parser = Parser.new
    parser.format_lines(@request)
    assert_equal "Verb: GET", parser.diagnostic.split("\n")[1]
  end

  def test_it_produces_accurate_diagnostic
    parser = Parser.new
    parser.format_lines(@request)
    diagnostic = "<pre>\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nHost:  localhost\nPort: 9292\nAccepts: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\n"
    assert_equal diagnostic, parser.diagnostic
  end

  def test_it_returns_accurate_parameters
    parser = Parser.new
    parser.format_lines(@request_param)
    assert_equal "word", parser.env["Parameter"]
  end

  def test_it_returns_accurate_values_from_parameters
    parser = Parser.new
    parser.format_lines(@request_param)
    assert_equal "example", parser.env["Value"]
  end

end
