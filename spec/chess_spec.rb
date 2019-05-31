require './chess.rb'

describe Board do
  describe '#showboard' do
    it 'shows the blank board'
  end

  describe '#valid_space' do
    it 'confirms 1,1 is a valid space' do
      a = Board.new
      expect(a.valid_space([1,1])).to eql(true)
    end
    it 'confirms 0,0 is invalid' do
      a = Board.new
      expect(a.valid_space([0,0])).to eql(false)
    end
    it 'confirms 8,8 is valid' do
      a = Board.new
      expect(a.valid_space([8,8])).to eql(true)
    end
    it 'confirms 9,8 is invalid' do
      a = Board.new
      expect(a.valid_space([9,8])).to eql(false)
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
  end 
end