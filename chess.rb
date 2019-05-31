class Game
end

class Board

  def initialize
    @width = 8
    @length = 8
    @pieces = []
    # system ('cls')
    @pieces << Rook.new([1,1],'black')
    @pieces << Knight.new([1,2], 'black')
    @pieces << Bishop.new([1,3], 'black')
    @pieces << Queen.new([1,4], 'black')
    @pieces << King.new([1,5], 'black')
    @pieces << Bishop.new([1,6], 'black')
    @pieces << Knight.new([1,7], 'black')
    @pieces << Rook.new([1,8], 'black')
    @pieces << Pawn.new([2,1], 'black')
    @pieces << Pawn.new([2,2], 'black')
    @pieces << Pawn.new([2,3], 'black')
    @pieces << Pawn.new([2,4], 'black')
    @pieces << Pawn.new([2,5], 'black')
    @pieces << Pawn.new([2,6], 'black')
    @pieces << Pawn.new([2,7], 'black')
    @pieces << Pawn.new([2,8], 'black')
    @pieces << Rook.new([8,1],'white')
    @pieces << Knight.new([8,2], 'white')
    @pieces << Bishop.new([8,3], 'white')
    @pieces << Queen.new([8,4], 'white')
    @pieces << King.new([8,5], 'white')
    @pieces << Bishop.new([8,6], 'white')
    @pieces << Knight.new([8,7], 'white')
    @pieces << Rook.new([8,8], 'white')
    @pieces << Pawn.new([7,1], 'white')
    @pieces << Pawn.new([7,2], 'white')
    @pieces << Pawn.new([7,3], 'white')
    @pieces << Pawn.new([7,4], 'white')
    @pieces << Pawn.new([7,5], 'white')
    @pieces << Pawn.new([7,6], 'white')
    @pieces << Pawn.new([7,7], 'white')
    @pieces << Pawn.new([7,8], 'white')
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

  def showboard
    row_count = 1
    until row_count == 9
      col_count = 1
      row_string = "#{row_count} "
      until col_count == 9
        piece_present = false
        @pieces.each do |piece|
          if piece.pos[0] == row_count and piece.pos[1] == col_count
            row_string += piece.display
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
    @team == 'black' ? @display_black : @display_white
  end
end

class Pawn < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'pawn'
    @display_black = "\u265F"
    @display_white = "\u2659 "
  end

end

class Rook < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'rook'
    @display_black = "\u265c "
    @display_white = "\u2656 "
  end

end

class Knight < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'knight'
    @display_black = "\u265e "
    @display_white = "\u2658 "
  end
end

class Bishop < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'bishop'
    @display_black = "\u265d "
    @display_white = "\u2657 "
  end
end

class Queen < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'queen'
    @display_black = "\u265b "
    @display_white = "\u2655 "
  end
end

class King < Piece

  def initialize(pos=[0,0], team='black')
    @pos = pos
    @team = team
    @type = 'king'
    @display_black = "\u265a "
    @display_white = "\u2654 "
  end
end


