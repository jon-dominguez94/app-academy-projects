
class Board
  attr_reader :grid
  
  def initialize(grid = Array.new(4){Array.new(5)})
    @grid = grid
  end
  
  def [](pos)
    row,col = pos
    @grid[row][col]
  end
  
  def []=(pos, card)
    row,col = pos
    @grid[row][col] = card 
  end
  
  def populate
    2.times do 
      (1..10).each do |card|
        pos = nil
        until is_empty?(pos)
          pos = random_pos
        end
        self[pos] = Card.new(card)
      end 
    end
  end
  
  def is_empty?(pos)
    return false if pos == nil
    self[pos] == nil
  end
  
  def random_pos
    row = (0...4).to_a.sample
    col = (0...5).to_a.sample
    [row, col]
  end
  
  def won?
    @grid.all? do |row|
      row.none? {|elem| elem.face_down?} 
    end
  end
  
  def render
    print "   "
    @grid[0].length.times do |num|
      print " #{num}  |"
    end
    print "\n"
    @grid.each_with_index do |row, row_idx|
      puts "----------------------------"
      print "#{row_idx} |"
      row.each do |elem|
        print " #{elem.display_card_info}"
        if elem.display_card_info == nil
          print "   |"
        elsif elem.display_card_info > 9
          print " |"
        else
          print "  |"
        end
      end
      print "\n"
    end
  end
  
  def reveal(guessed_pos)
    self[guessed_pos].reveal
    self[guessed_pos].face_value
  end
end

