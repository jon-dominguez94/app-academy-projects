class Computer
  attr_reader :name

  def initialize(name, dictionary)
    @name = name
    @dictionary = dictionary
  end

  def guess(fragment, num)
    alphabet = ("a".."z").to_a
    @candidate_words = @dictionary.select do |word|
      word.index(fragment) == 0
    end

    @losing_moves = []
    alphabet.each do |letter|
      @losing_moves << letter if @candidate_words.include?(fragment + letter)
    end

    winning_moves = []
    p left_overs = alphabet - @losing_moves
    left_overs.each do |ch|
      winning_moves << ch if long_words(fragment + ch, num)
    end

    p winning_moves
    p @losing_moves
    if @losing_moves.empty? && winning_moves.empty?
      @other_letters = alphabet - (@losing_moves + winning_moves)
      @other_letters.select do |ch|
        @candidate_words.any? do |word|
          word.index(fragment + ch) == 0
        end
      end.sample
    elsif winning_moves.empty?
      @losing_moves.sample
    else
      winning_moves.sample
    end

  end

  def long_words(string, num)
    @candidate_words = @candidate_words.select do |word|
      word.index(string) == 0
    end

    @candidate_words.none? do |word|
      word.length >= string.length + num - 1
    end
  end

end
