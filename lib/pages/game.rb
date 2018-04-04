class Game
  attr_reader :guesses,
              :answer
  def initialize
    @guesses = Hash.new
    @answer = rand(1..100)
    "Good Luck"
  end

  def guess_answer(guess)
    if  guess > @answer
      @guesses[guess] = "Too High"
    elsif guess < @answer
      @guesses[guess] = "Too Low"
    elsif guess == @answer
      @guesses[guess] = "Correct!"
    end
  end

  def complile_answer_response(guess)
    guess_answer(guess)
    response = "<body> #{@guesses.count} guesses have been made"
    response += "You just guessed #{guess}\n#{guess} is #{@guesses[guess]}"
    if @guesses[guess] == "Correct!"
      response += "Well done!</body>"
    end
  end


end
