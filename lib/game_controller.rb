require_relative "game"

class GameController 
  def initialize
    @game = Game.new()
  end

  def play
    p @game.secret_word
    p @game.letter_array
    p @game.guess_array
  end
end