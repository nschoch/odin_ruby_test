module Enumerable
  def my_each
    counter = 0
    while self[counter].nil? == false
      yield(self[counter]) if block_given?
      counter += 1
    end
  end

  def my_each_with_index
    counter = 0
    while self[counter].nil? == false
      yield(self[counter], counter) if block_given?
      counter += 1
    end
  end

  def my_select
    new_array = []
    self.my_each do |x|
      if yield(x)
        new_array << x
      end
    end
    return new_array
  end

  def my_all
    counter = 0
    status = true
    while status == true && self[counter].nil? == false
      unless yield(self[counter])
        status = false
      end
      counter += 1
    end
    return status
  end

  def my_any
    status = false
    self.my_each do |x|
      if yield(x)
        status = true
      end
    end
    return status
  end

  def my_none
    status = true
    self.my_each do |x|
      if yield(x)
        status = false
      end
    end
    return status
  end

  def my_count
    reported_count = 0
    self.my_each do |x|
      if block_given?
        if yield(x)
          reported_count += 1
        end
      else
        reported_count += 1
      end
    end

    return reported_count
  end

  # def my_map
  #   new_array = []
  #   self.my_each do |x|
  #       new_array << yield(x)
  #   end
  #   return new_array
  # end

  def my_map(&block)
    new_array = []
    unless block.nil?
      self.my_each do |x|
          new_array << block.call(x)
      end
    else
        self.my_each do |x|
          new_array << yield(x)
        end
    end
    return new_array
  end

  def my_inject(arg = nil)
    memo = arg if arg
    self.my_each do |element|
      if memo
        memo = yield(memo, element)
      else
        memo = element
      end
    end
    return memo
  end

  def multiply_els
    return self.my_inject { |sum, n| sum * n }
  end

end

p = Proc.new { |x| x* 3 }

puts [1,2,3].my_map(&p)

# puts [1,2,3].my_map { |x| x * 3 h}

