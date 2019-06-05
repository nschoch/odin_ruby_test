require './piece'

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
      expect(r.raw_moves(a)).to eql([[1,2],[2,1]])
      r.pos = [1,3]
      expect(r.raw_moves(a)).to eql([[1, 4], [1, 5], [1, 6], [1, 7], [1, 2], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3], [7, 3], [8, 3]])
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
      expect(b.raw_moves(a)).to eql([[4,2],[2,2]])
      b.pos = [1,3]
      expect(b.raw_moves(a)).to eql([[2, 4], [3, 5], [4, 6], [5, 7], [2,2]])
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
      expect(q.raw_moves(a)).to eql([[4, 2], [5, 1], [3, 1], [5, 2], [3, 2]])
      q.pos = [4,4]
      expect(q.raw_moves(a)).to eql([[4, 5], [4, 6], [4, 7], [4, 3], [4, 4], [5, 4], [6, 4], [7, 4], [8, 4], [3, 4], [5, 5], [6, 6], [7, 7], [5, 3], [7, 5], [8, 6], [3, 3], [3, 5], [5, 7]])
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