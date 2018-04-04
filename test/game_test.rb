require 'minitest/autorun'
require 'minitest/pride'
require './lib/pages/game'
class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new
    assert_instance_of Game, game
  end

  def test_it_generates_answer
    game = Game.new
    assert_instance_of Integer, game.answer
  end

  def test_game_responds_to_too_low
    game = Game.new
    guess = (game.answer - 1)
    assert_equal "#{guess} is Too Low", game.guess_answer(guess)
  end
  def test_game_responds_to_too_high
    game = Game.new
    guess = (game.answer + 1)
    assert_equal "#{guess} is Too High", game.guess_answer(guess)
  end

  def test_game_responds_to_correct_guess
    game = Game.new
    guess = game.answer
    assert_equal "Nice! That's correct!", game.guess_answer(guess)
  end
end
