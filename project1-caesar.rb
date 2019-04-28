
def caesar_cipher(message='Need a message', shift=1)

  newMessage = message.strip.chars.map do |c|
    char_conversion(c, shift)
  end
  puts newMessage.join
end

def char_conversion(char, shift)
  capital_characters = ("A".."Z").to_a
  lowercase_characters = ("a".."z").to_a
  
  if (capital_characters.include?(char))
    target_new_char = char.ord + shift
    if (target_new_char > 90)
      target_new_char = target_new_char - 90 + 64
    elsif (target_new_char < 65)
      target_new_char = 90 - (65 - target_new_char)
    end
  elsif (lowercase_characters.include?(char)) 
    target_new_char = char.ord + shift
    if (target_new_char > 122)
      target_new_char = target_new_char - 122 + 96
    elsif (target_new_char < 97)
      target_new_char = 122 - (97 - target_new_char)
    end
  else
    target_new_char = char.ord
  end

  target_new_char.chr
end

caesar_cipher('What a string!', 5)
# puts char_conversion('c',1).inspect

