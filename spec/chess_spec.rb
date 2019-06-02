require './chess.rb'

describe Board do
  describe '#showboard' do
    it 'shows the blank board' 
    # do
    #   a = Board.new
    #   expect(a.showboard).to eql(1)
    # end
  end

  describe '#space_valid?' do
    a = Board.new
    it 'confirms 1,1 is a valid space' do
      expect(a.space_valid?([1,1])).to eql(true)
    end
    it 'confirms 0,0 is invalid' do
      expect(a.space_valid?([0,0])).to eql(false)
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
      expect(a.move('a2b2')).to eql('black pawn already occupies space')
    end
    it 'destroys opponent if in space' do
      expect(a.move('a1a7')).to eql([1,7])
      a.showboard
    end
    it 'allows clear movement' do
      expect(a.move('a2a4')).to eql([1,4])
      a.showboard
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

  describe '#available_moves' do
    it 'shows pawn option to move 1 or 2 spaces forward' do
      a = Board.new
      p = a.find_occupant([1,2])
      expect(p.available_moves(a)).to eql([[1,3],[1,4]])
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