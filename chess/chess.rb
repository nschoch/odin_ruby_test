require_relative 'board'
require 'yaml'

class Game
  def initialize
    @board = Board.new
    @save_file = 'chess_save.yaml'
    @message_cache = ''
    puts "Let's play chess."
    @turn_order = ['white', 'black']
    load_save
    system "clear"
    play
  end

  def play
    team_up = @turn_order[0]
    until @board.check_mate?(team_up)
      @board.show_board
      if @message_cache != ''
        puts @message_cache
        @message_cache = ''
      end
      puts "Check #{team_up}!" if @board.check?(team_up)
      puts "#{team_up}'s turn"
      action = request_action
      system "clear"
      if action.nil?
        @message_cache = "Try again"  
      elsif action == 'Q'
        @message_cache = "Saving and quitting"
        save_to_yaml
        exit
      elsif action == 'R'
        @message_cache = "Resetting the board"
        @board = Board.new
        @turn_order = ['white', 'black']
      else
        result = @board.move(action, team_up)
        if result == "good"
          @turn_order.shift
          @turn_order << team_up
          team_up = @turn_order[0]
        else
          @message_cache = "Error: #{result}"
        end
      end
    end
    @message_cache = "Checkmate #{team_up}"
    @board.show_board
    remove_save
  end

  def request_action
    response = nil
    while response.nil? || response == ''
      puts "What is your next move? [Or (q)uit and save; (r)eset]"
      response = gets.chomp
    end
    response.upcase
  end

  def save_to_yaml
    save_data = YAML.dump ({
      :board => @board,
      :turn_order => @turn_order
    })
    file = File.open(@save_file, "w")
    file.puts save_data
    file.close
  end

  def remove_save
    if File.exist?(@save_file)
      File.delete(@save_file)
    end
  end

  def load_save
    if File.exist?(@save_file)
      file = File.open(@save_file, "r")
      file_data = file.read
      save_data = YAML.load file_data
      save_data.each do |x, value| # how was this handled?
        instance_variable_set("@#{x}", value)
      end
    end
  end
end

Game.new