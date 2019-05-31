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
  attr_reader :pos, :team, :type

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'undefined'
  end

  def announce
    return "I am a #{@team} #{@type}. I am located at #{@pos.to_s}."
  end
end

class Pawn < Piece

  def initialize(pos=[0,0])
    super(pos)
    super(team)
    @type = 'pawn'
  end

  def available_moves
  end

end

class Rook < Piece

  def initialize(pos=[0,0])
    super(pos)
    super(team)
    @type = 'rook'
  end
end

class Knight < Piece

  def initialize(pos=[0,0])
    super(pos)
    super(team)
    @type = 'knight'
  end
end

class Bishop < Piece

  def initialize(pos=[0,0])
    super(pos)
    super(team)
    @type = 'bishop'
  end
end

class Queen < Piece

  def initialize(pos=[0,0])
    super(pos)
    super(team)
    @type = 'queen'
  end
end

class King < Piece

  def initialize(pos=[0,0])
    super(pos)
    super(team)
    @type = 'king'
  end
end


