require_relative 'game'
require_relative 'player'

class GameController
  def initialize
    @game = Game.new
    @player = Player.new
  end

  def play
    start_choice = @player.initial_prompt
    case start_choice
    when '1'
      puts ''
    when '2'
      fls = Dir.entries('saves/').select { |f| f.end_with?('.yaml') }
      saves = fls.map.with_index(1) do |save, index|
        "[#{index}] #{save}"
      end
      puts ''
      puts 'Saves:'
      puts saves
      puts ''
      puts 'What is the number of the save you want to load?'
      save_number = gets.chomp.to_i
      @game.load_game(fls[save_number - 1])
      puts 'Game loaded!'
      puts ''
    end

    while @game.remaining_guesses != 0 && !@game.win?
      game_choice = @player.take_input

      case game_choice
      when '1'
        puts ''
      when '2'
        puts 'What would you like to name your save?'
        @game.save_game(gets.chomp)
        puts 'Game successfully saved! Exiting...'
        exit
      end

      @player.take_guess
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
      puts ''

    end

    if @game.win?
      puts "Congratulations! you guessed the word #{@game.secret_word}"
    else
      puts "Game over, the word was #{@game.secret_word}"
    end
  end
end
