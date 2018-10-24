require_relative 'card'
require_relative 'board'
require_relative 'humanplayer'
require_relative 'computerplayer'
require 'byebug'

class Game 
  def initialize(player)
    @board = Board.new
    @board.populate
    @guessed_pos = nil 
    @previous_guess = nil
    @player = player

  end
  
  def play 
    # debugger
    until @board.won?
      @board.render
      make_guess(get_move)
      system("clear")
    end 
  end
  
  def get_move
    # begin
      p pos = @player.get_guess
      # raise unless valid_pos?(pos)
    # rescue 
    #   puts "Not a valid input"
    #   retry
    # end
    pos 
  end
  
  def make_guess(pos)
    if @previous_guess
      @board.reveal(pos)
      @player.receive_revealed_card(pos, @board.reveal(pos))
      if @board[pos].matches?(@board[@previous_guess])
        @player.receive_match(pos, @board.reveal(pos))
        @player.receive_match(pos, @board.reveal(@previous_guess))
      else 
        @board.render
        sleep(1.5)
        @board[pos].hide 
        @board[@previous_guess].hide
      end
    else
      @previous_guess = pos 
      @board.reveal(pos)
      @player.receive_revealed_card(pos, @board.reveal(pos))
      @player.revealed_card = @board.reveal(pos)
      @board.render
      make_guess(get_move)
    end
    @previous_guess = nil  
  end 
  
  def valid_pos?(pos)
    row, col = pos
    return true if row < @board.grid.length && col < @board.grid[0].length 
    false
  end 
end

if __FILE__ == $PROGRAM_NAME
  player = ComputerPlayer.new
  game = Game.new(player)
  game.play 
end