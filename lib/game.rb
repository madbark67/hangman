require_relative 'dictionary_loader'
require 'yaml'

class Game
  attr_accessor :secret_word, :letter_array, :guess_array, :remaining_guesses, :remaining_letters, :incorrect_letters

  def initialize
    @dictionary_loader = DictionaryLoader.new('lib/google-10000-english-no-swears.txt')
    @secret_word = ''
    set_secret
    @letter_array = secret_word.split('')
    @guess_array = Array.new(@secret_word.length, '_')
    @remaining_letters = ('a'..'z').to_a
    @incorrect_letters = []
    @remaining_guesses = 7
  end

  def save_game(save_name)
    save = {
      'secret_word' => secret_word,
      'remaining_guesses' => remaining_guesses,
      'incorrect_letters' => incorrect_letters,
      'remaining_letters' => remaining_letters,
      'guess_array' => guess_array
    }
    serialized_object = YAML.dump(save)

    File.write("saves/#{save_name}.yaml", serialized_object)
  end

  def load_game(file_name)
    serialized_object = File.read("saves/#{file_name}")
    save = YAML.load(serialized_object)
    self.secret_word = save['secret_word']
    self.letter_array = secret_word.split('')
    self.remaining_guesses = save['remaining_guesses']
    self.incorrect_letters = save['incorrect_letters']
    self.remaining_letters = save['remaining_letters']
    self.guess_array = save['guess_array']

    puts '==========================================================================='
    puts "You have #{remaining_guesses} guesses remaining"
    display_guess
    puts
    puts 'Remaining letters:'
    puts remaining_letters.join(' ')
    puts
    puts 'Incorrect letters:'
    puts incorrect_letters.join(' ')
    puts '==========================================================================='
    puts ''
  end

  def set_secret
    self.secret_word = @dictionary_loader.pick_word
  end

  def remove_guess_count
    self.remaining_guesses = remaining_guesses - 1
  end

  def process_guess(guess)
    return if @guess_array.include?(guess) || @incorrect_letters.include?(guess)

    remaining_letters.delete(guess)
    unless letter_array.include?(guess)
      incorrect_letters << guess
      remove_guess_count
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
