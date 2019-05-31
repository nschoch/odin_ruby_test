require './chess.rb'

describe Board do
  describe '#showboard' do
    it 'shows the blank board'
  end
end

describe Piece do
  describe '#announce' do
    it 'announces the piece type and position' do
      a = Piece.new
      expect(a.announce).to eql('I am a undefined. I am located at [0, 0].')
    end
  end
end

describe Pawn do
  describe '#announce' do
    it 'announces that it is a pawn with a base location' do
      a = Pawn.new
      expect(a.announce).to eql('I am a pawn. I am located at [0, 0].')
    end
  end

  describe '#available_moves' do
  end 
end