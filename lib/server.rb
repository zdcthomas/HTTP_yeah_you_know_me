require 'socket'
require_relative './parser'
class Serv
  attr_reader :tcp_server,
              :client,
              :request_lines
  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @parser = Parser.new
  end

  def begin_connection
    @client = @tcp_server.accept
  end

  def receive_request_lines
    @request_lines = []
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
    @request_lines
  end

  def terminate
    @client.close
    puts "Connection Terminated"
  end

  def response(output)
    output = "<html><head></head><body>#{output}</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
    puts "Header: \n\r #{headers}\r\nResponse: #{output}"
  end

  def diagnostics
    "<pre>
    Verb: #{@parser["Verb"]}\n
    Path: #{@parser["Path"]}\n
    Protocol: #{@parser["Protocol"]}\n
    Host: #{@parser["Host"]}\n
    Port: #{@parser["Port"]}\n
    Accepts: #{@parser["Accepts"]}\n"
  end

end
while server.begin_connection
  server.receive_request_lines
  server.response(server.request_lines)
  server.diagnostics
  server.terminate
end
