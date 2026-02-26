class DictionaryLoader
  def initialize(path)
    @path = path
  end

  def pick_word
    eligible_options = File.readlines(@path, chomp: true).select do |word|
      word.length.between?(5, 12)
    end

    eligible_options.sample
  end
end
