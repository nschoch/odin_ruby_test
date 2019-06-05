require_relative 'piece'

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

  def check?(team)
    king = find_king(team)
    opponent = (team == 'white') ? 'black' : 'white'
    opponent_moves = show_opponent_moves(opponent)
    if opponent_moves.include?(king.pos)
      true
    else
      false
    end
  end

  def check_mate?(team)
    king = find_king(team)
    opponent = (team == 'white') ? 'black' : 'white'
    opponent_moves = show_opponent_moves(opponent)
    if opponent_moves.include?(king.pos)
      king_moves = show_available_moves(king)
      king_moves.each_with_index do |kmove, index|
          if opponent_moves.include?(kmove)
            king_moves.delete_at(index)
          end
        end
      if king_moves == []
        true
      else
        false
      end
    else
      return false
    end
  end

  def find_king(team)
    @pieces.select { |piece| piece.team == team and piece.type == 'king'}[0]
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

  def move(instruction, team)
    inst_arr = instruction.split('')
    origin_loc = [translate(inst_arr[0].upcase),inst_arr[1].to_i]
    dest_loc = [translate(inst_arr[2].upcase),inst_arr[3].to_i]
    moving_piece = find_occupant(origin_loc)

    return "no piece at origin" if moving_piece == nil
    return "invalid destination" if space_valid?(dest_loc) == false
    return "not your piece" if moving_piece.team != team
    return "location not in piece moveset" unless show_available_moves(moving_piece).include?(dest_loc)

    destination_occupant = find_occupant(dest_loc)
    if destination_occupant != nil
      return "#{destination_occupant.team} #{destination_occupant.type} already occupies space" if destination_occupant.team == moving_piece.team
      @pieces.delete(destination_occupant)
      puts "Destroyed #{destination_occupant.team} #{destination_occupant.type}"
    end
    moving_piece.pos = dest_loc
    return "good"
  end

  def show_available_moves(piece, recursive=true)
    return "No piece" if piece.nil?
    moves = piece.raw_moves(self)
    moves = moves.select { |x| space_valid?(x) }
    moves = moves.select do |x| 
        occupant = find_occupant(x)
        if occupant == nil
          true
        elsif occupant.team == piece.team
          false
        else
          true
        end
      end
    
    if piece.type == 'king' && recursive == true
      original_pos = piece.pos
      opponent = (piece.team == 'white') ? 'black' : 'white'

       moves = moves.reject do |move|
          current_guy = find_occupant(move)
          current_guy.pos = [0,0] unless current_guy.nil?
          piece.pos = move
          opponent_moves = show_opponent_moves(opponent)
          piece.pos = original_pos
          current_guy.pos = move unless current_guy.nil?
          opponent_moves.include?(move)
         end
      return moves
    else
      return moves
    end
  end

  def show_opponent_moves(opponent_team)
    moves = []
    @pieces.each do |x| 
      if x.team == opponent_team
        moves += show_available_moves(x, false)
      else
        next
      end
    end
    moves
  end

  def show_board
    row_count = 1

    puts "  A B C D E F G H"
    until row_count == 9
      col_count = 1
      row_string = "#{row_count} "
      until col_count == 9
        piece_present = false
        @pieces.each do |piece|
          if piece.pos[0] == col_count and piece.pos[1] == row_count 
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
      row_string += "#{row_count}"
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