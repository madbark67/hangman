require_relative 'game'
require_relative 'player'

class GameController
  def initialize
    @game = Game.new
    @player = Player.new
  end

  def play
    while @game.remaining_guesses != 0 && !@game.win?
      @player.take_input
      # p @game.letter_array
      @game.process_guess(@player.guess)
      @player.guess = ''
      puts '==========================================================================='
      puts "You have #{@game.remaining_guesses} guesses remaining"
      @game.display_guess
      puts
      puts 'Remaining letters:'
      puts @game.remaining_letters.join(' ')
      puts
      puts 'Incorrect letters:'
      puts @game.incorrect_letters.join(' ')
      puts '==========================================================================='

    end

    if @game.win?
      puts "Congratulations! you guessed the word #{@game.secret_word}"
    else
      puts "Game over, the word was #{@game.secret_word}"
    end
  end
end
