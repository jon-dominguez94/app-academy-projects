class Player
attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess(fragment, num)
    begin
      puts "Which letter #{name}?"
      answer = gets.chomp
      alert_invalid_guess(answer)
    rescue
      puts "Invalid Input"
      retry
    end
    return answer
  end

  def alert_invalid_guess(letter)
    alpha = ("a".."z").to_a
    if !alpha.include?(letter)
      raise "invalid"
    end
  end
end
