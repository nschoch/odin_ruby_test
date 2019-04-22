def fibonacci(n) 
    prevNum = 0
    newNum = 1
    if n < 0
        "Error"
    else
        for i in 1..n
            if ( i<= 1) then
                newNum = 1
            else
                temp = newNum
                newNum = newNum + prevNum
                prevNum = temp
            end
            puts newNum.to_s
        end
    end
end

def sumEvenFibonacci(n) 
    prevNum = 0
    newNum = 1
    sum = 0
    if n < 0
        "Error"
    else
        while newNum < 4000000
            if (prevNum <= 0) then
                newNum = 1
                prevNum = 1
            else
                temp = newNum
                newNum = newNum + prevNum
                prevNum = temp
                if (newNum % 2 == 0) then
                    sum += newNum
                end
            end
            puts newNum.to_s
        end
    end
    sum
end

puts "what number do we fibonaccizie?"
number = gets.chomp.to_i
puts "This is it: " + sumEvenFibonacci(number).to_s