require './tictactoe'

describe Player do
  describe "#score" do
    a = Player.new
    it "should increment @score" do
      a.score
      expect(a.score).to eql(2)
    end

    it "should report score" do
      expect(a.show_score).to eql(2)
    end

    it "should reset score" do
      a.reset_score
      expect(a.show_score).to eql(0)
    end
  end
end

describe Board do
  describe "#pick_space" do
    it "should allow picking a space" do
      a = Board.new 
      expect(a.pick_space('a1','X')[:result]).to eql(true)
      expect(a.pick_space('a2','X')[:result]).to eql(true)
      expect(a.pick_space('a3','X')[:result]).to eql(true)
    end

    it "should not allow picking an occupied space" do
      a = Board.new 
      a.pick_space('a1','X')
      expect(a.pick_space('a1','O')[:result]).to eql(false)
    end

    it "should end game upon three in a row" do
      a = Board.new
      a.pick_space('a1','X')
      a.pick_space('a2','X')
      a.pick_space('a3','X')
      expect(a.check_game_over[:game_over]).to eql(true)
      a = Board.new
      a.pick_space('a1','O')
      a.pick_space('a2','O')
      a.pick_space('a3','O')
      expect(a.check_game_over[:game_over]).to eql(true)
      a = Board.new
      a.pick_space('a1','X')
      a.pick_space('b2','X')
      a.pick_space('c3','X')
      expect(a.check_game_over[:game_over]).to eql(true)
    end

  end
end