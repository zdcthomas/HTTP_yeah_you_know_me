class Response
  def initialize(output)
    @output = output
  end

  def respond_with_header
    @output = "<html><head></head><body>#{@output}</body></html>"
    @headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
    puts "Header: \n\r #{headers}\r\nResponse: #{@output}"
  end

  def

  end
end
