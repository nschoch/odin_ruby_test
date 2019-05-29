require './connect4'

describe Board do
  describe "#draw_board" do
    it "should show a 6x7 board empty" do
      a = Board.new
      expect(a.grid).to eql([['_','_','_','_','_','_','_'],
      ['_','_','_','_','_','_','_'],
      ['_','_','_','_','_','_','_'],
      ['_','_','_','_','_','_','_'],
      ['_','_','_','_','_','_','_'],
      ['_','_','_','_','_','_','_']])
    end
  end

  describe "#place_token" do
    a = Board.new
    it "should place a token in the target spot" do
      expect(a.place_token(1,1,'@')).to eql(true)
    end
    it "should not allow tokens to overlap" do
      expect(a.place_token(1,1,'@')).to eql(false)
    end
  end

  describe "#space_valid?" do
    a = Board.new
    it "should confirm spaces valid if on board" do
      expect(a.space_valid?([1,1])).to eql(true)
      expect(a.space_valid?([0,0])).to eql(true)
      expect(a.space_valid?([5,6])).to eql(true)
      expect(a.space_valid?([5,5])).to eql(true)
      expect(a.space_valid?([4,4])).to eql(true)
    end
    it "should invalidate spaces if not on board" do
      expect(a.space_valid?([-1,-1])).to eql(false)
      expect(a.space_valid?([7,6])).to eql(false)
      expect(a.space_valid?([6,7])).to eql(false)
      expect(a.space_valid?([5,20])).to eql(false)
    end
  end

  describe "#move_options" do
    a = Board.new
    it "show correct space options" do
      expect(a.move_options([1,1])).to eql([[1, 2], [2, 2], [2, 1], [2, 0], [1, 0], [0, 0], [0, 1], [0, 2]])
      expect(a.move_options([0,0])).to eql([[0, 1], [1, 1], [1, 0]])
      expect(a.move_options([6,5])).to eql([[5, 4], [5, 5], [5, 6]])
    end
  end

  # describe "#adjacent_count" do
    
  #   it "should count three adjacent spaces with a fake" do
  #     a = Board.new
  #     a.place_token(1,1,'@')
  #     a.place_token(2,1,'@')
  #     a.place_token(3,1,'@')
  #     a.place_token(5,3,'@')
  #     a.place_token(4,3,'#')
  #     expect(a.adjacent_match_count([1,1], '@')).to eql(3)
  #   end
    
  #   it "should count four adjacent spaces" do
  #     a = Board.new
  #     a.place_token(1,1,'@')
  #     a.place_token(2,1,'@')
  #     a.place_token(3,1,'@')
  #     a.place_token(4,1,'@')
  #     expect(a.adjacent_match_count([4,1], '@')).to eql(4)
  #   end
  # end

  describe "#first_empty_row" do
    it "should show the next empty row" do
      a = Board.new
      a.place_token(0,0,'@')
      a.show_board
      expect(a.first_empty_row(0)).to eql(1)
    end
  end

  describe "#game_over?" do
    it "should end the game when 4 are placed" do
      a = Board.new
      a.place_token(1,1,'@')
      a.place_token(2,1,'@')
      a.place_token(3,1,'@')
      a.place_token(4,1,'@')
      a.place_token(0,1,'@')
      expect(a.game_over?([4,1])).to eql(true)
    end
    it "should not end if 4 aren't adjacent" do
      a = Board.new
      a.place_token(0,0,'@')
      a.place_token(0,1,'#')
      a.place_token(0,2,'#')
      a.place_token(0,3,'@')
      a.place_token(0,4,'@')
      a.place_token(0,5,'@')
      a.place_token(0,6,'#')
      a.place_token(1,3,'#')
      a.place_token(1,4,'@')
      puts a.show_board
      expect(a.game_over?([1,4])).to eql(false)
    end
  end

  describe "#count_adjacent" do
    it "should count matches" do
      a = Board.new
      a.place_token(0,0,'@')
      a.place_token(0,1,'#')
      a.place_token(0,2,'#')
      a.place_token(0,3,'#')
      a.place_token(0,4,'#')
      a.place_token(0,5,'#')
      a.place_token(0,6,'#')
      a.place_token(1,3,'#')
      a.place_token(1,4,'@')
      # puts a.show_board
      expect(a.count_adjacent([0,1],0,1,"#")).to eql(5)
      expect(a.count_adjacent([0,3],1,0,"#")).to eql(1)
    end
  end

  describe "#show_board" do
    # it "should show a blank board at the beginning of the game" do
    #   a = Board.new
    #   expect(a.show_board).to eql("The board:\n 0 1 2 3 4 5 6\n _ _ _ _ _ _ _\n _ _ _ _ _ _ _\n _ _ _ _ _ _ _\n _ _ _ _ _ _ _\n _ _ _ _ _ _ _\n _ _ _ _ _ _ _\n")
    # end
  end
end