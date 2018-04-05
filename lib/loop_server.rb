require './lib/server'
require './lib/parser'
require './lib/response'
require './lib/conductor'
require 'pry'

class ServerLoop
  def initialize(port)
    @server = Serv.new(port)
    @conductor = Conductor.new(@server)
  end

  def start_loop
    loop do
      @server.begin_connection
      # binding.pry
      @server.receive_request_lines
      request = @server.request_lines
      page = @conductor.conduct(request)
      # binding.pry
      @response = Response.new(page)
      puts @response.report_response
      @server.client.puts @response.respond_with_header.join
      # binding.pry
      if (page.class == Array) && (page[1]== "exit")
        exit
      end
      @server.terminate
    end
  end

end
