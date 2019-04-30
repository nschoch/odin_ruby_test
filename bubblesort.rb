def bubble_sort(num_array)
  change = true
  until change == false
    change = false
    num_array.each_with_index do |num, index|
      if !num_array[index+1].nil? && num_array[index+1] < num
        num_array[index] = num_array[index+1]
        num_array[index+1] = num
        change = true
      end
    end
  end
  num_array
end

# puts bubble_sort([4,3,78,2,0,2]).inspect

def bubble_sort_by(num_array)
  change = true
  until change == false
    change = false
    num_array.each_with_index do |num, index|
      if !num_array[index+1].nil? && yield(num_array[index], num_array[index+1]) > 0
        num_array[index] = num_array[index+1]
        num_array[index+1] = num
        change = true
      end
    end
  end
  num_array
end

puts (bubble_sort_by(['hi', 'hello', 'hey']) do |left, right| 
  left.length - right.length 
end).inspect