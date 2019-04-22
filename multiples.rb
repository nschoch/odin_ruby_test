
def findMultiples()
    puts "Enter an integer you'd like to sum the multiples of 3 and 5 for"
    limit = gets.chomp.to_i
    sum = 0

    for i in 1..limit do
        if ( i % 3 == 0 or i % 5 == 0)
            sum += i
        end
    end
    puts "The sum is #{sum}."
end

findMultiples