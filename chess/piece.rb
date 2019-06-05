require_relative 'board'

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

  def running_moves(board,piece,adjustments)
    col = piece.pos[0]
    row = piece.pos[1]
    running_moves = []
    adjustments.each do |adj|
      counter = 0
      until counter >= 7
        test_col = col + adj[0] != col ? (col + adj[0] + counter) : col
        test_row = row + adj[1] != row ? (row + adj[1] + counter) : row 
        test_loc = [test_col, test_row]
        if board.space_valid?(test_loc) == false
          counter = 7
        elsif board.space_occupied?(test_loc)
          running_moves << test_loc
          counter = 7
        else
          running_moves << test_loc
          counter +=1
        end
      end
    end
    return running_moves
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

  def raw_moves(board)
    col = @pos[0]
    row = @pos[1]
    initial_moveset = (@direction == 'positive') ? [[col,row+1]] : [[col, row-1]]
    if @move_count == 0
      initial_moveset << ((@direction == 'positive') ? [col, row+2] : [col, row-2])
    end
    raw_moves = initial_moveset.select { |loc| board.space_valid?(loc) }
    raw_moves = raw_moves.reject { |loc| board.space_occupied?(loc) } # pawns can't attack straight on
    raw_moves + diagonally_adjacent(board)
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

  def raw_moves(board)
    moveset = []
    adjustments = [[0,1],[0,-1],[1,0],[-1,0]]
    moveset + running_moves(board,self,adjustments)
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

  def raw_moves(board)
    col = @pos[0]
    row = @pos[1]
    moveset = [[col+1, row+2],
               [col+2, row+1],
               [col+2, row-1],
               [col+1, row-2],
               [col-1, row-2],
               [col-2, row-1],
               [col-2, row+1],
               [col-1, row+2]]
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

  def raw_moves(board)
    moveset = []
    adjustments = [[1,1],[1,-1],[-1,-1],[-1,1]]
    moveset + running_moves(board,self,adjustments)
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

  def raw_moves(board)
    moveset = []
    adjustments = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[1,-1],[-1,-1],[-1,1]]
    moveset + running_moves(board,self,adjustments).uniq
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

  def raw_moves(board)
    col = @pos[0]
    row = @pos[1]
    moveset = [[col+0, row+1],
               [col+1, row+1],
               [col+1, row+0],
               [col+1, row-1],
               [col+0, row-1],
               [col-1, row-1],
               [col-1, row+0],
               [col-1, row+1]]
  end
end