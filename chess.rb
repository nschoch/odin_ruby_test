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

  def display
    @team == 'black' ? @display_black.encode('utf-8') : @display_white.encode('utf-8')
  end
end

class Pawn < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'pawn'
    @display_black = "\u265f"
    @display_white = "\u2659"
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

end

class Knight < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'knight'
    @display_black = "\u265e"
    @display_white = "\u2658"
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
end

class Queen < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'queen'
    @display_black = "\u265b"
    @display_white = "\u2655"
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
end


