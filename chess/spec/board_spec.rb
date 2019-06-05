require './board'

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

  describe '#show_available_moves' do
    it 'moves match expectations for various pieces' do
      a = Board.new
      piece = a.find_occupant([1,1])
      expect(a.show_available_moves(piece)).to eql([])

      piece = a.find_occupant([2,1])
      expect(a.show_available_moves(piece)).to eql([[3, 3], [1, 3]])

      piece = a.find_occupant([3,1])
      expect(a.show_available_moves(piece)).to eql([])

      piece = a.find_occupant([4,1])
      expect(a.show_available_moves(piece)).to eql([])
      piece.pos = [4,6]
      expect(a.show_available_moves(piece)).to eql([[4, 7], [4, 5], [5, 6], [6, 6], [7, 6], [8, 6], [3, 6], [5, 7], [5, 5], [7, 7], [3, 5], [3, 7]])
      piece.pos = [4,1]

      piece = a.find_occupant([5,1])
      expect(a.show_available_moves(piece)).to eql([])
      piece.pos = [2,5]
      expect(a.show_available_moves(piece)).to eql([[3, 5], [3, 4], [2, 4], [1, 4], [1, 5]])

      piece = a.find_occupant([1,2])
      expect(a.show_available_moves(piece)).to eql([[1, 3], [1, 4]])

      piece = a.find_occupant([1,8])
      expect(a.show_available_moves(piece)).to eql([])

      piece = a.find_occupant([2,8])
      expect(a.show_available_moves(piece)).to eql([[3, 6], [1, 6]])

      piece = a.find_occupant([3,8])
      expect(a.show_available_moves(piece)).to eql([])

      piece = a.find_occupant([4,8])
      expect(a.show_available_moves(piece)).to eql([])

      piece = a.find_occupant([5,8])
      expect(a.show_available_moves(piece)).to eql([])

      piece = a.find_occupant([1,7])
      expect(a.show_available_moves(piece)).to eql([[1, 6], [1, 5]])
      piece.pos = [2,3]
      expect(a.show_available_moves(piece)).to eql([[1, 2], [3, 2]])

    end
  end

  describe '#show_opponent_moves' do
    it 'shows all the moves by the opponent' do
      a = Board.new
      expect(a.show_opponent_moves('white')).to eql([[3, 6], [1, 6], [8, 6], [6, 6], [1, 6], [1, 5],
       [2, 6], [2, 5], [3, 6], [3, 5], [4, 6], [4, 5], [5, 6], [5, 5], [6, 6], [6, 5], [7, 6], [7, 5],
        [8, 6], [8, 5]])
    end
  end

  describe '#find_king' do
    it 'shows location of king' do
      a = Board.new
      expect(a.find_king('white').pos).to eql([5,8])
      expect(a.find_king('black').pos).to eql([5,1])
    end
  end

  describe '#check?' do
    a = Board.new
    it 'shows no check for starting position' do
      expect(a.check?('white')).to eql(false)
      expect(a.check?('black')).to eql(false)
    end

    it 'shows check when needed' do
      p = a.find_king('white')
      p.pos = [5,3]
      expect(a.check?('white')).to eql(true)
    end
  end

  describe '#check_mate?' do
    a = Board.new
    it 'shows no checkmate in starting position' do
      expect(a.check_mate?('white')).to eql(false)
      expect(a.check_mate?('black')).to eql(false)
    end

    it 'shows checkmate' do
      k = a.find_king('white')
      k.pos = [1,3]
      q = a.find_occupant([4,1])
      q.pos = [2,5]
      expect(a.check_mate?('white')).to eql(true)
    end
  end 

end