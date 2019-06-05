require_relative 'board'

class Game
  def initialize
    @board = Board.new
    puts "Let's play chess."
    @turn_order = ['black', 'white']
    current_player = turn_order.shift
  end

  def play
    while game_over == false
      puts "#{current_player}'s turn"
    end
  end

end