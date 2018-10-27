class Computer
  attr_reader :name
  attr_accessor :candidate_words

  def initialize(name, dictionary)
    @name = name
    @dictionary = dictionary
    @candidate_words = dictionary
  end

  def get_losing_moves(fragment, alphabet)
    losing_moves = []
    alphabet.each do |letter|
      losing_moves << letter if @candidate_words.include?(fragment + letter)
    end
    losing_moves
  end

  def get_winning_moves(fragment, alphabet, num)
    winning_moves = []
    alphabet.each do |ch|
      string = fragment + ch
      possible_words = @candidate_words.select {|word| word.index(string) == 0}
      if !possible_words.empty?
        if possible_words.all? {|word| word.length < (fragment.length + num - 1)}
          winning_moves << ch
        end
      end
    end
    winning_moves
  end

  def guess(fragment, num)
    alphabet = ("a".."z").to_a
    @candidate_words = @dictionary.select do |word|
      word.index(fragment) == 0
    end

    losing_moves = get_losing_moves(fragment, alphabet)

    winning_moves = get_winning_moves(fragment, (alphabet - losing_moves), num)

    other_letters = alphabet - (losing_moves + winning_moves)
    other_letters = other_letters.select do |ch|
      @candidate_words.any? do |word|
        word.index(fragment + ch) == 0
      end
    end

    if winning_moves.empty?
      (losing_moves + other_letters).sample
    else
      winning_moves.sample
    end

  end

end
