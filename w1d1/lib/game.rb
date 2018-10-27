require_relative "player"
require_relative "computer"

GHOST = "GHOST"


class Game

  attr_reader :players, :dictionary, :losses
  attr_accessor :fragment, :current_player

  def initialize(players, fragment, dictionary)
    @players = players
    @fragment = fragment
    @dictionary = dictionary
    @current_player = @players[0]
    @losses = Hash.new(0)
    @players.each do |player|
      @losses[player.name] = 0
    end

  end


  def next_player!
    current_player_idx = @players.index(@current_player)
    next_player_idx = (current_player_idx + 1) % @players.length
    @current_player = @players[next_player_idx]
  end

  def prev_player!
    current_player_idx = @players.index(@current_player)
    next_player_idx = (current_player_idx - 1) % @players.length
    @current_player = @players[next_player_idx]
  end

  def valid_play?(string)
    @dictionary.any? do |word|
      word.index(string) == 0
    end
  end

  def display
    puts @fragment
  end

  def play
    @fragment = ""
    until won?
      puts %x{clear}
      display_standings
      puts "\n\n#{@current_player.name}'s turn."
      display
      play_round
      next_player!
    end
    prev_player!
    puts "\n\n#{@current_player.name} loses!"
    @losses[@current_player.name] += 1
    unless losses[@current_player.name] == 5
      play
    end
  end

  def play_round
    guess = @current_player.guess(@fragment, @players.length) #"c"
    if valid_play?(fragment + guess)
      @fragment += guess
    else
      puts "Not a Valid Play. Please try again"
      play_round
    end
  end

  def won?
    @dictionary.include?(fragment)
  end

  def record(player)
    losses = @losses[player]
    return GHOST[0...losses]
  end

  def display_standings
    @losses.each_key do |key|
      puts "#{key} : #{record(key)}"
    end
  end


end

if __FILE__ == $PROGRAM_NAME
  dictionary = File.readlines("dictionary.txt").map(&:chomp)

  player1 = Player.new("Rob")
  player2 = Player.new("Ant")
  player3 = Computer.new("PC", dictionary)
  player4 = Computer.new("Mac", dictionary)
  players = [player1, player2, player4, player3]
  game = Game.new(players, "", dictionary)
  game.play
end
