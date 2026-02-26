require_relative 'dictionary_loader'

class Game
  attr_accessor :secret_word, :letter_array, :guess_array, :turns, :remaining_letters, :incorrect_letters

  def initialize
    @dictionary_loader = DictionaryLoader.new('lib/google-10000-english-no-swears.txt')
    @secret_word = ''
    set_secret
    @letter_array = secret_word.split('')
    @guess_array = Array.new(@secret_word.length, '_')
    @remaining_letters = ('a'..'z').to_a
    @incorrect_letters = []
    @turns = 0
  end

  def set_secret
    self.secret_word = @dictionary_loader.pick_word
  end

  def take_turn
    self.turns = turns + 1
  end

  def process_guess(guess)
    remaining_letters.delete(guess)
    unless letter_array.include?(guess)
      incorrect_letters << guess
      take_turn
      return
    end
    letter_array.each_with_index do |letter, index|
      guess_array[index] = letter if guess == letter
    end
  end

  def display_guess
    puts guess_array.join(' ')
  end

  def win?
    return false if guess_array.include?('_')

    true
  end
end
