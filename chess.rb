class Game
end

class Board

  def initialize
    @width = 8
    @length = 8
    @pieces = []
    @pieces << Rook.new([1,1],'black')
    @pieces << Knight.new([2,1], 'black')
    @pieces << Bishop.new([3,1], 'black')
    @pieces << Queen.new([4,1], 'black')
    @pieces << King.new([5,1], 'black')
    @pieces << Bishop.new([6,1], 'black')
    @pieces << Knight.new([7,1], 'black')
    @pieces << Rook.new([8,1], 'black')
    @pieces << Pawn.new([1,2], 'black')
    @pieces << Pawn.new([2,2], 'black')
    @pieces << Pawn.new([3,2], 'black')
    @pieces << Pawn.new([4,2], 'black')
    @pieces << Pawn.new([5,2], 'black')
    @pieces << Pawn.new([6,2], 'black')
    @pieces << Pawn.new([7,2], 'black')
    @pieces << Pawn.new([8,2], 'black')
    @pieces << Rook.new([1,8],'white')
    @pieces << Knight.new([2,8], 'white')
    @pieces << Bishop.new([3,8], 'white')
    @pieces << Queen.new([4,8], 'white')
    @pieces << King.new([5,8], 'white')
    @pieces << Bishop.new([6,8], 'white')
    @pieces << Knight.new([7,8], 'white')
    @pieces << Rook.new([8,8], 'white')
    @pieces << Pawn.new([1,7], 'white')
    @pieces << Pawn.new([2,7], 'white')
    @pieces << Pawn.new([3,7], 'white')
    @pieces << Pawn.new([4,7], 'white')
    @pieces << Pawn.new([5,7], 'white')
    @pieces << Pawn.new([6,7], 'white')
    @pieces << Pawn.new([7,7], 'white')
    @pieces << Pawn.new([8,7], 'white')
  end

  def space_valid?(desired_loc)
    col = desired_loc[1]
    row = desired_loc[0]
    (col >= 1 and col <= 8 and row >= 1 and row <= 8) ? true : false
  end

  def space_occupied?(desired_loc)
    col = desired_loc[1]
    row = desired_loc[0]
    occupied = false
    @pieces.each do |piece|
      if piece.pos[0] == row and piece.pos[1] == col
        occupied = true
        break
      end
    end
    occupied
  end

  def find_occupant(loc)
    col = loc[1]
    row = loc[0]
    occupant = nil
    @pieces.each do |piece|
      if piece.pos[0] == row and piece.pos[1] == col
        occupant = piece
        break
      end
    end
    occupant
  end

  def move(instruction)
    inst_arr = instruction.split('')
    origin_loc = [translate(inst_arr[0].upcase),inst_arr[1].to_i]
    dest_loc = [translate(inst_arr[2].upcase),inst_arr[3].to_i]
    moving_piece = find_occupant(origin_loc)

    return "no piece at origin" if moving_piece == nil
    return "invalid destination" if space_valid?(dest_loc) == false
    return "location not in piece moveset" unless moving_piece.available_moves(self).include?(dest_loc)

    destination_occupant = find_occupant(dest_loc)
    if destination_occupant != nil
      return "#{destination_occupant.team} #{destination_occupant.type} already occupies space" if destination_occupant.team == moving_piece.team
      @pieces.delete(destination_occupant)
      puts "Destroyed #{destination_occupant.team} #{destination_occupant.type}"
    end
    moving_piece.pos = dest_loc
  end

  def show_board
    row_count = 1
    until row_count == 9
      col_count = 1
      row_string = "#{row_count} "
      until col_count == 9
        piece_present = false
        @pieces.each do |piece|
          if piece.pos[0] == col_count and piece.pos[1] == row_count 
            row_string += "\e[0;30m" + piece.display + "\e[0m "
            piece_present = true
            break
          end
        end
        if piece_present == false
          row_string += "\u26F6 "
        end
        col_count += 1
      end
      puts row_string
      row_count += 1
    end
    puts "  A B C D E F G H"
  end

  def translate(character)
    case character
      when 1
        "A"
      when 2
        "B"
      when 3
        "C"
      when 4
        "D"
      when 5
        "E"
      when 6
        "F"
      when 7
        "G"
      when 8
        "H"
      when "A"
        1
      when "B"
        2
      when "C"
        3
      when "D"
        4
      when "E"
        5
      when "F"
        6
      when "G"
        7
      when "H"
        8
      end

  end

end

class Piece
  attr_reader :pos, :team, :type
  attr_writer :pos

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'undefined'
  end

  def announce
    return "I am a #{@team} #{@type}. I am located at #{@pos.to_s}."
  end

  def display
    @team == 'black' ? @display_black : @display_white
  end

end

class Pawn < Piece
  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'pawn'
    @display_black = "\u265F"
    @display_white = "\u2659"
    @move_count = 0
    @direction = (@pos[1] == 2) ? 'positive' : 'negative'
  end

  def available_moves(board)
    col = @pos[0]
    row = @pos[1]
    initial_moveset = (@direction == 'positive') ? [[col,row+1]] : [[col, row-1]]
    if @move_count == 0
      initial_moveset << ((@direction == 'positive') ? [col, row+2] : [col, row-2])
    end
    available_moves = initial_moveset.select { |loc| board.space_valid?(loc) }
    available_moves = available_moves.reject { |loc| board.space_occupied?(loc) } # pawns can't attack straight on
    available_moves << diagonally_adjacent(board)
    available_moves
  end

  def diagonally_adjacent(board)
    col = @pos[0]
    row = @pos[1]
    search_left = (@direction == 'positive') ? [col-1, row+1] : [col-1, row-1]
    search_right = (@direction == 'positive') ? [col+1, row+1] : [col+1, row-1]
    left_occupant = board.find_occupant(search_left)
    right_occupant = board.find_occupant(search_right)
    additional_moves = []
    if left_occupant.nil? == false and left_occupant.team != @team
      additional_moves << left_occupant.pos
    end
    if right_occupant.nil? == false and right_occupant.team != @team
      additional_moves << right_occupant.pos
    end
    additional_moves
  end

end

class Rook < Piece
  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'rook'
    @display_black = "\u265c"
    @display_white = "\u2656"
  end

  def available_moves(board)
  end
end

class Knight < Piece
  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'knight'
    @display_black = "\u265e"
    @display_white = "\u2658"
  end

  def available_moves(board)
  end
end

class Bishop < Piece
  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'bishop'
    @display_black = "\u265d"
    @display_white = "\u2657"
  end

  def available_moves(board)
  end
end

class Queen < Piece
  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'queen'
    @display_black = "\u265b"
    @display_white = "\u2655"
  end

  def available_moves(board)
  end
end

class King < Piece
  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'king'
    @display_black = "\u265a"
    @display_white = "\u2654"
  end

  def available_moves(board)
  end
end


