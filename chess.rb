class Piece
  attr_reader :x, :y, :last_position

  def initialize(pos=[0,0], last_position=nil)
    @x = pos[0]
    @y = pos[1]
    @last_position = last_position
    @potential_positions
  end

  def valid?
    self.x.between?(0, 7) && self.y.between?(0,7)
  end

  def move(pos1, pos2)
    puts "DEFAULT MOVEMENT SET"
  end

  def to_s
    "#{x+1}, #{y+1}"
  end
  
end

class Knight < Piece

  def move(pos1, pos2)
    puts "Moving #{pos1} #{pos2}"
  end

  def available_moves
    @potential_positions = [Knight.new([self.x-2, self.y+1], self),
     Knight.new([self.x-1, self.y+2], self),
     Knight.new([self.x+1, self.y+2], self),
     Knight.new([self.x+2, self.y+1], self),
     Knight.new([self.x+2, self.y-1], self),
     Knight.new([self.x+1, self.y-2], self),
     Knight.new([self.x-1, self.y-2], self),
     Knight.new([self.x-2, self.y-1], self)].select { |space| space.valid? }
  end

  def path_finder(target_pos)
    puts "Searching path"
    path_search(self.available_moves, target_pos)
  end

  def path_search(child_options, target_pos)
    queue = child_options
    count = 0
    until queue.empty?
      count += 1
      current = queue.shift
      # puts "start loop #{count} x: #{current.x}"
      if [current.x, current.y] == target_pos
        # puts "found it #{[current.x, current.y]} #{target_pos}"
        return current.show_path
      else
        current.available_moves.each { |option| queue.push(option)}
        # puts "still looking #{count}"
      end
    end
  end

  def show_path
    parent = self
    path = []
    until parent.nil?
      path.unshift([parent.x, parent.y])
      parent = parent.last_position
    end
    path
  end
    

end

def knight_moves(pos1, pos2)
  a = Knight.new(pos1)
  p a.path_finder(pos2)
end

knight_moves([0,0],[1,2])
knight_moves([0,0],[3,3])
knight_moves([3,3],[0,0])