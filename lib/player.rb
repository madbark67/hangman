class Player
  attr_accessor :guess

  def initialize
    @guess = ''
  end

  def take_input
    while guess.length != 1
      puts 'Guess a letter:'
      self.guess = gets.chomp.downcase
    end
  end
end
