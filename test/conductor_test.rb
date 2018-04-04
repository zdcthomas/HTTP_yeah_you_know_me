require_relative "../lib/conductor.rb"
require "Minitest/autorun"
require "Minitest/pride"

class ConductorTest < MiniTest::Test

  def setup
  end

  def test_it_exists
    conductor = Conductor.new
    assert_instance_of Conductor, conductor
  end

  def test_counter_begins_at_zero
    conductor = Conductor.new
    assert_equal 0, conductor.counter
  end

  def test_counter_increments_after_every_redirect
    conductor = Conductor.new
    assert_equal 0, conductor.counter
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection: keep-alive",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                     "Accept-Encoding: gzip, deflate, br",
                     "Accept-Language: en-US,en;q=0.9"]
     conductor.conduct(request_lines)
     assert_equal 1, conductor.counter
  end

  def test_it_returns_diagnostic_at_root
    conductor = Conductor.new
    request_lines = ["GET / HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection: keep-alive",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                     "Accept-Encoding: gzip, deflate, br",
                     "Accept-Language: en-US,en;q=0.9"]
    actual = conductor.conduct(request_lines)
    expected = "<pre>\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nHost:  localhost\nPort: 9292\nAccepts: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\n"
    assert_equal expected, actual
  end

  def test_hello_returns_hello_world
    conductor = Conductor.new
    request_lines = ["GET /hello HTTP/1.1",
                     "Host: localhost:9292",
                     "Connection: keep-alive",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                     "Accept-Encoding: gzip, deflate, br",
                     "Accept-Language: en-US,en;q=0.9"]
     actual = conductor.conduct(request_lines)
     assert_equal "Hello World (0)", actual
   end

  def test_hello_world_iterates
    conductor = Conductor.new
    request_lines = ["GET /hello HTTP/1.1",
                    "Host: localhost:9292/hello",
                    "Connection: keep-alive",
                    "Upgrade-Insecure-Requests: 1",
                    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                    "Accept-Encoding: gzip, deflate, br",
                    "Accept-Language: en-US,en;q=0.9"]
    actual = conductor.conduct(request_lines)
    assert_equal "Hello World (0)", actual
    actual = conductor.conduct(request_lines)
    assert_equal "Hello World (1)", actual
    actual = conductor.conduct(request_lines)
    assert_equal "Hello World (2)", actual
  end

  def test_it_displays_current_date_time
    conductor = Conductor.new
    request_lines = ["GET /datetime HTTP/1.1",
                    "Host: localhost:9292/hello",
                    "Connection: keep-alive",
                    "Upgrade-Insecure-Requests: 1",
                    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                    "Accept-Encoding: gzip, deflate, br",
                    "Accept-Language: en-US,en;q=0.9"]
    actual = conductor.conduct(request_lines)
    expected  = Time.now.strftime('%I:%M%p on %A, %B %d, %Y')
    assert_equal expected, actual
  end

  def test_it_shuts_down
    conductor = Conductor.new
    request_lines = ["GET /shutdown HTTP/1.1",
                    "Host: localhost:9292/hello",
                    "Connection: keep-alive",
                    "Upgrade-Insecure-Requests: 1",
                    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                    "Accept-Encoding: gzip, deflate, br",
                    "Accept-Language: en-US,en;q=0.9"]
    actual = conductor.conduct(request_lines)
    assert_equal ["Total Requests: 1", "exit"], actual
  end

  def test_conductor_runs_word_search_successfully
    conductor = Conductor.new
    request_lines =["GET /word_search?word=example HTTP/1.1",
                    "Host: localhost:9292",
                    "Connection: keep-alive",
                    "Upgrade-Insecure-Requests: 1",
                    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                    "Accept-Encoding: gzip, deflate, br",
                    "Accept-Language: en-US,en;q=0.9"]
    actual = conductor.conduct(request_lines)
    assert_equal "example is a known word", actual
  end

  def test_conductor_returns_correct_negative_word_search
    conductor = Conductor.new
    request_lines =["GET /word_search?word=blargh HTTP/1.1",
                    "Host: localhost:9292",
                    "Connection: keep-alive",
                    "Upgrade-Insecure-Requests: 1",
                    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                    "Accept-Encoding: gzip, deflate, br",
                    "Accept-Language: en-US,en;q=0.9"]
    actual = conductor.conduct(request_lines)
    assert_equal "blargh is not a known word", actual
  end
end
