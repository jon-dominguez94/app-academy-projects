class ComputerPlayer
  attr_accessor :revealed_card
  def initialize
    @prev_guesses = Hash.new {|hash,key| hash[key] = []}
    @prev_guess = nil 
    @revealed_card = nil 
    @known_cards = Hash.new {|hash,key| hash[key] = []}
    @matched_cards = Hash.new {|hash,key| hash[key] = []}
  end
  
  def get_guess
    if !@prev_guess
      return two_are_known if two_are_known
      return random 
    else
      return two_are_known if two_are_known
      if @known_cards.has_key?(@revealed_card)
        @prev_guess = nil
        return @known_cards[@revealed_card]
      else
        @prev_guess = nil 
        return random 
      end 
    end 
  end
  
  def translate(pos)
    "#{pos[0]},#{pos[1]}"
  end
  
  def random
      known_positions = deconstruct_hash(@known_cards) + deconstruct_hash(@matched_cards)
      pos = random_pos
      until known_positions.none? { |arr| arr==pos }
        pos = random_pos
      end
      pos 
  end
  
  def random_pos
    row = (0...4).to_a.sample
    col = (0...5).to_a.sample
    [row, col]
  end
  
  def receive_revealed_card(pos, card)
    @known_cards[card] << pos
  end
  
  def receive_match(pos, card)
    @matched_cards[card] << pos
  end
  
  def deconstruct_hash(hash)
    result = []
    hash.each do |k, v|
      if v.first.is_a?(Array)
        result << v.first
        result << v.last
      else
        result << v
      end
    end
    result
  end
  
  def two_are_known
    if @prev_guess
      if  @known_cards[@prev_guess].length > 1
        pos =  @known_cards[@prev_guess].last
        @known_cards.delete(@prev_guess)
        @prev_guess = nil
        return pos
      end
    else
      @known_cards.each do |k,v|
        if v.length > 1 
          # debugger
          @prev_guess = k
          return v.first
        end
      end 
    end
    false
  end
    
      
end