def is_prime(num)
    (2..(num - 1)).each do |n| 
        return false if num % n == 0
    end
    true
end

# puts is_prime(25).to_s

require 'prime'

Prime.each(29) do |prime|
    p prime
end