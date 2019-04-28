def substrings(words, dictionary)
  output = {}
  dictionary.each do |word|
    count = words.downcase.scan(/#{word.downcase}/).length
    if (count > 0)
      output[word] = output[word].to_i + count
    end
  end
  puts output
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?",dictionary).inspect