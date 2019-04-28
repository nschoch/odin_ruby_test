def stock_picker(prices)
  best_combination = []
  max_proceeds = 0
  place_count = 0
  prices[0..-2].each do |x|
    prices[place_count+1...].each do |z|
      # puts "X: #{x} Z: #{z} X-Z $#{z-x}"
      if ( (z-x) > max_proceeds )
        max_proceeds = z - x
        best_combination = [place_count, prices.find_index(z)]
      end
    end
    place_count += 1
  end
  best_combination
end

puts stock_picker([17,3,6,9,15,8,6,1,10]).inspect