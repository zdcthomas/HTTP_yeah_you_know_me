require_relative './parser'
class Conductor
  def initialize
    @parser = Parser.new
  end


  def conduct(request)
    env = @parser.format_lines(request)
    if env["Verb"] == "GET"
      case env["Path"]
      when "/"
        @parser.diagnostic
      when "/hello"
        #HelloWorld
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
