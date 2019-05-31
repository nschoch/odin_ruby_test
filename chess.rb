class Game
end

class Board

  def initialize
    @width = 8
    @length = 8
  end

  def valid_space(desired_loc)
    col = desired_loc[1]
    row = desired_loc[0]
    if col >= 1 and col <= 8 and row >= 1 and row <= 8
      true
    else
      false
    end
  end
  
end

class Piece
  attr_reader :pos

  def initialize(pos=[0,0])
    @pos = pos
    @type = 'undefined'
    @frog = 'frog'
  end

  def announce
    return "I am a #{@type}. I am located at #{@pos.to_s}."
  end
end

class Pawn < Piece

  def initialize(pos=[0,0])
    super(pos)
    @type = 'pawn'
  end

  def available_moves
  end

end

class Rook < Piece
end

class Knight < Piece
end

class Bishop < Piece
end

class Queen < Piece
end

class King < Piece
end


