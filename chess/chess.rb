require_relative 'board'

class Game
  def initialize
    @board = Board.new
    puts "Let's play chess."
    @turn_order = ['white', 'black']
    play
  end

  def play
    team_up = @turn_order.shift
    @turn_order << team_up
    until @board.check_mate?(team_up)
      @board.show_board
      puts "#{team_up}'s turn"
      action = request_action
      system "clear"
      if action == 'Q'
        puts "Saving and quitting"
        exit
      else
        result = @board.move(action, team_up)
        if result == "good"
          team_up = @turn_order.shift
          @turn_order << team_up
        else
          puts "Error: #{result}"
        end
      end
    end
    puts "Checkmate #{team_up}"
  end

  def request_action
    puts "What is your next move? [Or (q)uit and save]"
    gets.chomp.upcase
  end
end

Game.new