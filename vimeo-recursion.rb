def append (ary, n)
  if n == 0
    return ary << 0
  else
    ary << n
    return append(ary, n-1)
  end
end

def append2 (ary, n)
  n.downto(0) do |i|
    ary << i
  end
  return ary
end


a = append2 [], 2
p a
b = append [], 3
p b