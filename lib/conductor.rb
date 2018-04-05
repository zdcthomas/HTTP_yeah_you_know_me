require 'pry'
require_relative './parser'
require_relative './pages/shutdown'
require_relative './pages/word_search'
require_relative './pages/you_know_me'
require_relative './pages/game'

class Conductor
  include ShutDown
  include WordSearch
  include YouKnowMe
  attr_reader :counter
  def initialize(server)
    @parser = Parser.new
    @counter = 0
    @server = server
  end


  def conduct(request)
    env = @parser.format_lines(request)
    case env["Verb"]
    when "GET"
      # binding.pry
      case env["Path"]
      when "/"
        @counter +=1
        return @parser.diagnostic
      when "/hello"
        @counter +=1
        return "Hello World (#{@counter - 1})"
      when "/datetime"
        @counter +=1
        Time.now.strftime('%I:%M%p on %A, %B %d, %Y')
      when "/shutdown"
        @counter +=1
        shutdown(@counter)
      when "/word_search"
        @counter += 1
        word_search(env["Value"])
      when "/you_know_me"
        @counter += 1
        opp
      when "/game"
        if @game
          @game.compile_answer_response
        else
          return "No game has been created."
        end
      end

    when "POST"
      case env["Path"]
      when "/game_start"
        @game = Game.new
        "Good Luck!"
      when "/game"
        if @game
          if env["Content-Length"].to_i > 0
            content_length = env["Content-Length"].to_i
            body = @server.read_body_from_post(content_length)
            guess = body.split("=")[1].to_i
            @game.guess_answer(guess)
          # binding.pry
          else
            @game.guess_answer(env["Value"].to_i)
          end 
        else
          return "No game has been created"
        end
      when "/"
        @counter +=1
        return @parser.diagnostic
      end
    end

  end
end
