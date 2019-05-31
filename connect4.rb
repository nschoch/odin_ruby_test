class Board
  attr_reader :grid, :player1, :player2, :last_play
  def initialize
    @grid = [['_','_','_','_','_','_','_'],
             ['_','_','_','_','_','_','_'],
             ['_','_','_','_','_','_','_'],
             ['_','_','_','_','_','_','_'],
             ['_','_','_','_','_','_','_'],
             ['_','_','_','_','_','_','_']]

    @player1 = '#'#"\u26aa".encode('utf-8')
    @player2 = 'o'#"\u26ab".encode('utf-8')
    @play_queue = []
    @last_play = []
  end

  def play
    @play_queue << @player1
    @play_queue << @player2
    puts "New game of Connect4"
    game_over = false
    until game_over == true
      puts show_board
      current_player = @play_queue.shift
      played_loc = request_placement(current_player)
      game_over = game_over?(@last_play)
      @play_queue << current_player
    end
    puts show_board
    puts "Game over. #{current_player} wins!"

  end

  def show_board
    output = ""
    output.concat("The board:\n")
    @grid[0].each_with_index { |x, index| output.concat("  #{index}  ")}
    output.concat("\n")
    @rev_grid = @grid.reverse
    @rev_grid.each do |col| 
      col.each { |x| output.concat("  #{x}  ")}
      output.concat("\n")
    end
    output
  end

  def request_placement(player)
    puts "#{player} select a column (0-6)"
    selection = gets.chomp.to_i
    if selection.between?(0,6)
      row = first_empty_row(selection)
      if row != false
        place_token(row,selection,player)
      else
        puts "Column already filled."
        request_placement(player)
      end
    else
      puts "Invalid input."
      request_placement(player)
    end
  end

  def first_empty_row(col)
    values_in_column = @grid.map { |row| row[col] }
    values_in_column.find_index('_') ? values_in_column.find_index('_') : false
  end

  def place_token(row,col,marker)
    if @grid[row][col] == '_'
      @grid[row][col] = marker
      @last_play = [row,col]
      return true
    else
      return false
    end
  end

  def game_over?(last_loc)
    marker = @grid[last_loc[0]][last_loc[1]]
    if (count_adjacent(last_loc, 0, 1, marker) >= 3 or 
       count_adjacent(last_loc, 1, 1, marker) >= 3 or
       count_adjacent(last_loc, 1, 0, marker) >= 3 or
       count_adjacent(last_loc, 1, -1, marker) >= 3 or
       count_adjacent(last_loc, 0, -1, marker) >= 3 or
       count_adjacent(last_loc, -1, -1, marker) >= 3 or
       count_adjacent(last_loc, -1, 0, marker) >= 3 or
       count_adjacent(last_loc, -1, 1, marker) >= 3)
      return true
    else
      return false
    end
  end

  def count_adjacent(start_loc, row_vector, col_vector, marker)
    next_loc = [start_loc[0]+row_vector, start_loc[1]+col_vector]
    if space_valid?(next_loc)
      if @grid[next_loc[0]][next_loc[1]] == marker
        return 1 + count_adjacent(next_loc, row_vector, col_vector, marker)
      else
        return 0
      end
    else
      return 0
    end
  end

  # def adjacent_match_count(location, marker, already_checked = [])
  #   row = location[0] # revise this to look in one direction only
  #   col = location[1]
  #   if @grid[row][col] == marker
  #     already_checked << location
  #     1 + move_options(location).sum do |loc| 
  #       if already_checked.include?(loc)
  #         0
  #       else
  #         adjacent_match_count(loc, marker, already_checked)
  #       end
  #     end
  #   else
  #     0
  #   end
  # end

  def space_valid?(location)
    row = location[0]
    col = location[1]
    row.between?(0,5) and col.between?(0,6)
  end

  def move_options(location)
    row = location[0]
    col = location[1]
    [[row,col+1],
     [row+1,col+1],
     [row+1,col],
     [row+1,col-1],
     [row,col-1],
     [row-1,col-1],
     [row-1,col],
     [row-1,col+1]].select { |loc| space_valid?(loc) }
  end
end

a = Board.new
a.play