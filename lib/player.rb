class Player
  attr_accessor :guess, :menu_choice, :initial_choice

  CHOICES = %w[1 2]

  def initialize
    @initial_choice = ''
    @menu_choice = ''
    @guess = ''
  end

  def initial_prompt
    self.initial_choice = nil
    until CHOICES.include?(initial_choice)
      puts 'Input an option from below'
      puts '[1] New Game'
      puts '[2] Load Game'
      self.initial_choice = gets.chomp
    end
    initial_choice
  end

  def take_input
    self.menu_choice = nil
    until CHOICES.include?(menu_choice)
      puts 'Input an option from below'
      puts '[1] Play'
      puts '[2] Save Game'
      self.menu_choice = gets.chomp
    end
    menu_choice
  end

  def take_guess
    while guess.length != 1
      puts 'Guess a letter:'
      self.guess = gets.chomp.downcase
      redo if guess.strip.empty?
    end
  end
end
