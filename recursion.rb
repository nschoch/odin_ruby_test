def fibs(n)
  last_num = 0
  this_num = 1
  if n < 0
    return 0
  else
    for i in 1..n
      if i <=1
        this_num = 1
      else
        temp = this_num
        this_num = this_num + last_num
        last_num = temp
      end
      puts this_num.to_s
    end
  end
end

def fibs_rec(n)
  n < 2 ? n : fibs_rec(n-1) + fibs_rec(n-2)
end

# fibs(5)
# puts fibs_rec(5)

def merge_sort(arr)
  n = arr.length
  return arr if n < 2

  a = merge_sort(arr[0...(n/2)])
  b = merge_sort(arr[(n/2)..-1])
  puts "hi A:#{a} B:#{b}"
  p merge(a,b)

end

def merge(left, right)
  a = []
  until left.empty? || right.empty?
    a << (left[0] <= right[0] ? left.shift : right.shift)
  end
  a + left + right
end

p merge_sort([5,8,3,1,4,6,7,9])