require_relative "dictionary_loader"

class Game 
  attr_accessor :secret_word, :letter_array, :guess_array

  def initialize
    @dictionary_loader = DictionaryLoader.new("lib/google-10000-english-no-swears.txt")
    @secret_word = ""
    set_secret
    @letter_array = self.secret_word.split('')
    @guess_array = Array.new(@secret_word.length, '_')
    @used_letters = Array.new()
    @turns = 0

  end

  def set_secret
    self.secret_word = @dictionary_loader.pick_word
  end
end