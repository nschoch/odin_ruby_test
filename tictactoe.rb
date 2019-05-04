class Board
  def initialize
    @occupied_spaces = [['-','-','-'],
                        ['-','-','-'],
                        ['-','-','-']]
  end

  def show_positions
    puts "Showing positions:"
    puts "  A | B | C"
    puts "1 #{@occupied_spaces[0][0]} | #{@occupied_spaces[0][1]} | #{@occupied_spaces[0][2]}"
    puts "2 #{@occupied_spaces[1][0]} | #{@occupied_spaces[1][1]} | #{@occupied_spaces[1][2]}"
    puts "3 #{@occupied_spaces[2][0]} | #{@occupied_spaces[2][1]} | #{@occupied_spaces[2][2]}"
  end

  def pick_space(space, marker)
    choice = space.split('')
    choice[1] = choice[1].to_i

    case choice[0].upcase
    when "A"
      column_choice = 0
    when "B"
      column_choice = 1
    when "C"
      column_choice = 2
    else
      return { :result => false, :error => "Invalid column choice." }
    end

    if choice[1] > 3 or choice[1] < 1
      return { :result => false, :error => "Invalid row choice." }
    else
      row_choice = choice[1] - 1
    end

    if (@occupied_spaces[row_choice][column_choice] != '-')
      return { :result => false, :error=> "Space already occupied." }
    else
      @occupied_spaces[row_choice][column_choice] = marker
      return { :result => true, :error => '' }
    end
    
  end

  def check_game_over
    b = @occupied_spaces
    if ((b[0][0] == b[0][1] and b[0][1] == b[0][2] and b[0][2] != "-") or #across the top
        (b[1][0] == b[1][1] and b[1][1] == b[1][2] and b[1][2] != "-") or #across the middle
        (b[2][0] == b[2][1] and b[2][1] == b[2][2] and b[2][2] != "-") or #across the bottom
        (b[0][0] == b[1][0] and b[1][0] == b[2][0] and b[2][0] != "-") or #down the left
        (b[0][1] == b[1][1] and b[1][1] == b[2][1] and b[2][1] != "-") or #down the middle
        (b[0][2] == b[1][2] and b[1][2] == b[2][2] and b[2][2] != "-") or #down the right
        (b[0][0] == b[1][1] and b[1][1] == b[2][2] and b[2][2] != "-") or #diag topL to bottomR
        (b[2][0] == b[1][1] and b[1][1] == b[0][2] and b[0][2] != "-"))   #diag bottomL to topR
      return { :game_over => true, :reason => 'victory' }
    elsif (b.any? { |row| row.any? { |column_value| column_value == '-'}})
      return { :game_over => false, :reason => '' }
    else
      return { :game_over => true, :reason => 'cats game' }  
    end
  end
end

class Player
  attr_reader :name
  def initialize(name)
    @name = name
    @score = 0
  end

  def score
    @score += 1
  end

  def show_score
    @score
  end

  def reset_score
    @score = 0
  end
end

class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    puts "Game initialized with #{@player1.name} and #{@player2.name}!"
    play_game
  end

  def play_game
    lets_play = "Y"
    while lets_play == "Y"
      board = Board.new
      turn = 1
      @active_player = rand(2) == 0 ? @player1 : @player2

      until board.check_game_over[:game_over]
        board.show_positions

        if @active_player == @player1
          marker = 'O'
        else
          marker = 'X'
        end

        puts "#{@active_player.name} (#{marker}) make a choice" 

        choice = gets.chomp
        attempt_to_pick = board.pick_space(choice, marker)
        if attempt_to_pick[:error] != ""
          puts "#{attempt_to_pick[:error]} Try again."
          redo
        end
        
        break if board.check_game_over[:game_over]
        turn += 1
        if @active_player == @player1
          @active_player = @player2
        else
          @active_player = @player1
        end
      end

      board.show_positions

      if (board.check_game_over[:reason] == 'victory')
        @active_player.score
        puts "#{@active_player.name} wins after #{turn} turns!"
      else
        puts "Meow. Cat's game!"
      end

      puts "Game over. Scores: #{@player1.name} #{@player1.show_score} #{@player2.name} #{@player2.show_score}"
      puts "Play again? Y or N"
      choice = gets.chomp.upcase
      if choice != "Y"
        lets_play = "N"
      end
    end
  end
end

first_player = Player.new('Luka')
second_player = Player.new('Brody')
new_game = Game.new(first_player, second_player)