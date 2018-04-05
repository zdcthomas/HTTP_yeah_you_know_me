class Game
  attr_reader :guesses,
              :answer
  def initialize
    @guesses = Hash.new
    @answer = rand(1..100)
    @recent_guess
  end

  def guess_answer(guess)
    @recent_guess = guess
    if  guess > @answer
      @guesses[guess] = "Too High"
    elsif guess < @answer
      @guesses[guess] = "Too Low"
    elsif guess == @answer
      @guesses[guess] = "Correct!"
      compile_answer_response
    end
  end

  def compile_answer_response
    if @recent_guess
      response = "<body> <p>#{@guesses.count} guesses have been made. <br /> "
      @guesses.each_pair{|guess, answer| response += "#{guess} was #{answer}<br />"}
      response += "You just guessed #{@recent_guess}<br />#{@recent_guess} is #{@guesses[@recent_guess]}"
      if @guesses[@recent_guess] == "Correct!"
        response += "Well done!<br /><iframe src='https://giphy.com/embed/26ufq9mryvc5HI27m' width='480' height='323' frameBorder='0' class='giphy-embed' allowFullScreen></iframe><p><a href='https://giphy.com/gifs/perfect-dave-chapelle-26ufq9mryvc5HI27m'>via GIPHY</a></p></p></body>"
      end
    else
      response = "No guesses have been made."
    end
    return response
  end


end
