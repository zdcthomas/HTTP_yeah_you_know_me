require 'pry'
require_relative './parser'
class Conductor
  attr_reader :counter
  def initialize
    @parser = Parser.new
    @counter = 0
  end


  def conduct(request)
    env = @parser.format_lines(request)
    if env["Verb"] == "GET"
      # binding.pry
      case env["Path"]
      when "/"
        @counter +=1
        return @parser.diagnostic
      when "/hello"
        @counter +=1
        return "Hello World (#{@counter - 1})"
      when "/datetime"
        # datetime
      when "/shutdown"
        # counter
        # shutdown
      when "/word_search"
      end
    end

  end
end
