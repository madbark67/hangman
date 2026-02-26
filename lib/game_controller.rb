require_relative 'game'
require_relative 'player'

class GameController
  def initialize
    @game = Game.new
    @player = Player.new
  end

  def play
    while @game.turns != 7 && !@game.win?
      @player.take_input
      # p @game.letter_array
      @game.process_guess(@player.guess)
      @player.guess = ''
      p @game.turns
      @game.display_guess
      p @game.remaining_letters
      p @game.incorrect_letters
    end
    puts "Did player win? #{@game.win?}"
    p @game.secret_word
  end
end
