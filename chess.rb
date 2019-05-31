class Game
end

class Board
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


