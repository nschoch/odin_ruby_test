require './chess.rb'

describe Board do

  describe '#space_valid?' do
    a = Board.new
    it 'confirms 1,1 is a valid space' do
      expect(a.space_valid?([1,1])).to eql(true)
    end
    it 'confirms 0,0 is invalid' do
      expect(a.space_valid?([0,0])).to eql(false)
    end
    it 'confirms 0,1 is invalid' do
      expect(a.space_valid?([0,1])).to eql(false)
    end
    it 'confirms 8,8 is valid' do
      expect(a.space_valid?([8,8])).to eql(true)
    end
    it 'confirms 9,8 is invalid' do
      expect(a.space_valid?([9,8])).to eql(false)
    end
  end
  
  describe '#space_occupied?' do
    a = Board.new
    it 'confirms space vacant' do
      expect(a.space_occupied?([3,3])).to eql(false)
    end
    it 'confirms space occupied' do
      expect(a.space_occupied?([1,1])).to eql(true)
    end
  end

  describe '#find_occupant' do
    a = Board.new
    it 'shows the rook in [1,1]' do
      expect(a.find_occupant([1,1])).to be_a(Rook)
    end
    it 'shows the pawn in [2,2]' do
      expect(a.find_occupant([2,2])).to be_a(Pawn)
    end
    it 'shows nil in invalid space [9,10]' do
      expect(a.find_occupant([9,10])).to eql(nil)
    end
    it 'shows nil in empty space [4,4]' do
      expect(a.find_occupant([4,4])).to eql(nil)
    end
  end

  describe "#translate" do
    a = Board.new
    it 'translates numbers to letters' do
      expect(a.translate(1)).to eql('A')
      expect(a.translate(2)).to eql('B')
      expect(a.translate(3)).to eql('C')
      expect(a.translate(4)).to eql('D')
      expect(a.translate(5)).to eql('E')
      expect(a.translate(6)).to eql('F')
      expect(a.translate(7)).to eql('G')
      expect(a.translate(8)).to eql('H')
    end
    it 'translates letters to numbers' do
      expect(a.translate('A')).to eql(1)
      expect(a.translate('B')).to eql(2)
      expect(a.translate('C')).to eql(3)
      expect(a.translate('D')).to eql(4)
      expect(a.translate('E')).to eql(5)
      expect(a.translate('F')).to eql(6)
      expect(a.translate('G')).to eql(7)
      expect(a.translate('H')).to eql(8)
    end
  end

  describe '#move' do
    a = Board.new
    it 'shows an error for an invalid destination' do
      expect(a.move('a2a9')).to eql('invalid destination')
    end
    it 'shows an error if the origin space is empty' do
      expect(a.move('c5c6')).to eql('no piece at origin')
    end
    it 'shows an error if moving onto the same team' do
      p = a.find_occupant([2,2])
      p.pos = [1,3]
      expect(a.move('a2a3')).not_to eql('[1,3]')
    end
    it 'destroys opponent if in space' do
      p = a.find_occupant([3,2])
      p.pos = [2,6]
      expect(a.move('b6c7')).to eql([3,7])
    end
    it 'allows clear movement' do
      expect(a.move('a2a4')).to eql([1,4])
    end
  end
end

describe Piece do
  describe '#announce' do
    it 'announces the piece type and position' do
      a = Piece.new
      expect(a.announce).to eql('I am a black undefined. I am located at [0, 0].')
    end
  end
end

describe Pawn do
  describe '#announce' do
    it 'announces that it is a pawn with a base location' do
      a = Pawn.new
      expect(a.announce).to eql('I am a black pawn. I am located at [0, 0].')
    end
  end

  describe '#display' do
    it 'shows a black pawn by default' do
      a = Pawn.new
      expect(a.display).to eql("\u265f".encode('utf-8'))
    end
  end

  describe '#raw_moves' do
    it 'shows pawn option to move 1 or 2 spaces forward' do
      a = Board.new
      p = a.find_occupant([1,2])
      expect(p.raw_moves(a)).to eql([[1,3],[1,4]])
    end   
    it 'shows white pawn option to move 1 or 2 spaces forward' do
      a = Board.new
      p = a.find_occupant([1,7])
      expect(p.raw_moves(a)).to eql([[1,6],[1,5]])
    end   
  end 

  describe '#diagonally_adjacent' do
    a = Board.new
    p = a.find_occupant([1,2])
    it 'gives nothing if no adjacent enemy pieces' do
      expect(p.diagonally_adjacent(a)).to eql([])
    end
    it 'shows diagonal option' do
      p.pos = [1,6]
      expect(p.diagonally_adjacent(a)).to eql([[2,7]])
    end
    it 'shows two diagonal options' do
      p.pos = [2,6]
      expect(p.diagonally_adjacent(a)).to eql([[1,7],[3,7]])
    end
  end
end

describe Rook do
  describe '#announce' do
    it 'announces the piece and position' do
      a = Board.new
      r = a.find_occupant([1,1])
      expect(r.announce).to eql('I am a black rook. I am located at [1, 1].')
    end
  end

  describe '#raw_moves' do
    it 'has the correct moveset' do
      a = Board.new
      r = a.find_occupant([1,1])
      expect(r.raw_moves(a)).to eql([])
      r.pos = [1,3]
      expect(r.raw_moves(a)).to eql([[1, 4], [1, 5], [1, 6], [1, 7], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3], [7, 3], [8, 3]])
    end
  end
end

describe Knight do
  describe '#raw_moves' do
    it 'has the correct moveset' do
      a = Board.new
      k = a.find_occupant([2,1])
      expect(k.raw_moves(a)).to eql([[3, 3], [4, 2], [4, 0], [3, -1], [1, -1], [0, 0], [0, 2], [1, 3]])
      k.pos = [4,4]
      expect(k.raw_moves(a)).to eql([[5, 6], [6, 5], [6, 3], [5, 2], [3, 2], [2, 3], [2, 5], [3, 6]])
    end
  end
end

describe Bishop do
  describe '#announce' do
    it 'announces the piece and position' do
      a = Board.new
      b = a.find_occupant([3,1])
      expect(b.announce).to eql('I am a black bishop. I am located at [3, 1].')
    end
  end

  describe '#raw_moves' do
    it 'has the correct moveset' do
      a = Board.new
      b = a.find_occupant([3,1])
      expect(b.raw_moves(a)).to eql([])
      b.pos = [1,3]
      expect(b.raw_moves(a)).to eql([[2, 4], [3, 5], [4, 6], [5, 7]])
    end
  end
end

describe Queen do
  a = Board.new
  q = a.find_occupant([4,1])

  describe '#announce' do
    it 'announces the piece and position' do
      expect(q.announce).to eql('I am a black queen. I am located at [4, 1].')
    end
  end

  describe '#raw_moves' do
    it 'has the correct moveset' do
      expect(q.raw_moves(a)).to eql([])
      q.pos = [4,4]
      expect(q.raw_moves(a)).to eql([[4, 5], [4, 6], [4, 7], [4, 3], [5, 4], [6, 4], [7, 4], [8, 4], [3, 4], [5, 5], [6, 6], [7, 7], [5, 3], [6, 4], [7, 5], [8, 6], [3, 3], [5, 3], [6, 4], [7, 5], [8, 6]])
    end
  end
end

describe King do
  a = Board.new
  k = a.find_occupant([5,1])

  describe '#announce' do
    it 'announces the piece and position' do
      expect(k.announce).to eql('I am a black king. I am located at [5, 1].')
    end
  end

  describe '#raw_moves' do
    it 'has the correct moveset' do
      expect(k.raw_moves(a)).to eql([[5, 2], [6, 2], [6, 1], [6, 0], [5, 0], [4, 0], [4, 1], [4, 2]])
      k.pos = [4,4]
      expect(k.raw_moves(a)).to eql([[4, 5], [5, 5], [5, 4], [5, 3], [4, 3], [3, 3], [3, 4], [3, 5]])
    end
  end
end

describe Game do
  # a = Game.new
end
