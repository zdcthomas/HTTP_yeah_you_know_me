class Game
  attr_reader :guesses,
              :answer
  def initialize
    @guesses = []
    @answer = rand(1..100)
    "Good Luck"
  end

  def guess_answer(guess)
    @guesses << guess

    if  guess > @answer
      return "#{guess} is Too High"
    elsif guess < @answer
      return "#{guess} is Too Low"
    elsif guess == @answer
      return "Nice! That's correct!"
    end
  end


end
