class HumanPlayer
  def initialize(name="I am a human")
    @name = name
  end
  
  def get_guess
      puts "Which position would you like to turn over? (\#,\#)"
      gets.chomp.split(",").map(&:to_i)
  end
  
  def receive_revealed_card(one, two)
  end
  
  def receive_match(one, two)
  end
  
end