class Board
  attr_reader :row_data

  def initialize(row_count, num_of_spaces=4)
    @row_count = row_count.to_i
    @num_of_spaces = num_of_spaces.to_i
    @row_data = []
  end

  def show_board
    puts draw_header
    puts draw_field
    puts draw_footer
  end

  def draw_header
    string = ''
    string += "--------------------------"
    string += "\n"
    @num_of_spaces.times do |i|
      string += "| #{i+1} "
    end
    string += "| status |"
    return string
  end

  def draw_field
    string = ''
    @row_count.times do |i| 
      string += "\n" if i != 0
      if @row_data[i].nil?
        string += "|   |   |   |   |        |"
      else
        @row_data[i][:guess].each_with_index do |chr, index|
          string += "|" if index == 0
          string += " #{chr.to_s} |"
        end
        string += "  #{@row_data[i][:exist]}-#{@row_data[i][:ordered]}   |"
      end
    end
    return string 
  end

  def draw_footer
    string = "--------------------------"
    return string
  end

  def add_attempt(attempt)
    @row_data[(attempt[:attempt].to_i-1)] = attempt
  end
end

class Robot
  def pick_colors(options, num_of_picks)
    puts "Robot: I have picked my colors. Good luck."
    return options.sample(num_of_picks)
  end

  def say_hi(player_name)
    puts "Robot: Hi #{player_name}!"
  end

  def guess(board, colors, num_of_colors)
    guess = []
    num_of_colors.times do |i|
      guess << colors.sample
    end
    guess = guess.join
    puts "I'm not sure. How about #{guess}?"
    return guess
  end
end

class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Game
  def initialize()
    @colors = ['A','B','C','D','E','F']
    @empty_rows = 0
    @num_of_colors = 4

    puts "Welcome to Mastermind!"

    puts "What is your name?"
    @player = Player.new(gets.chomp.to_s.capitalize)
    puts "Hi #{@player.name}!"

    puts "You will be playing against a robot. Say 'hi' robot."
    @robot = Robot.new
    @robot.say_hi(@player.name)

    puts "Who should guess? Robot (1) or you (2)?"
    response = gets.chomp.to_i
    while (response != 1 && response != 2)
      puts "I need a 1 or a 2"
      response = gets.chomp.to_i
    end

    if response == 1
      puts "OK, Robot will guess."
      @game_type = "robot"
    else
      puts "OK, you will guess."
      @game_type = "player"
    end

    puts "How many attempts?"
    @desired_attempts = gets.chomp.to_i
    while @desired_attempts <= 0 || @desired_attempts > 20
      puts "Input a number greater than 0 and at most 20."
      @desired_attempts = gets.chomp.to_i
    end

    @board = Board.new(@desired_attempts)

    puts "Begin!"
    @board.show_board
    play_game

  end
  
  def play_game
    exit_game = false
    game_over = false
    until exit_game
      attempt_count = 0

      puts "Robot, pick some colors."
      @code = @robot.pick_colors(@colors, @num_of_colors)
      # puts "Robot: #{@code}"
      # puts "Shh. Robot don't tell anyone."

      until game_over
        attempt_count += 1
        puts "Guess what colors (#{@colors.join()}) and order"
        guess = @game_type == 'player' ? gets.chomp : @robot.guess(@board, @colors, @num_of_colors)
        guess = guess.upcase.split('')

        puts "Guess #{guess}"
        exist = 0
        ordered = 0
        code_temp = @code.dup
        guess.each_with_index do |x, index|
          if code_temp.any? { |chr| chr == x }
            exist += 1
            code_temp.delete_at(code_temp.find_index(x))
          end
          if @code[index] == guess[index]
            ordered += 1
          end
        end
        @board.add_attempt({ :attempt => attempt_count, :guess => guess, :exist => exist, :ordered => ordered })
        if guess == @code
          puts "You figured it out!"
          game_over = true
        elsif (attempt_count+1 > @desired_attempts)
          puts "You didn't get it this time."
          puts "The answer was #{@code.join('')}."
          game_over = true
        else
          puts "Try again. #{@desired_attempts-attempt_count} attempt(s) remaining."
        end
        @board.show_board
      end

      puts "Play again?"
      if (gets.chomp.upcase != "Y")
        exit_game = true
      else
        game_over = false
      end
    end  
  end
end

Game.new