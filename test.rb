class BaseballPlayer
  attr_accessor :hits, :walks, :at_bats
  def initialize(hits, walks, at_bats)
    @hits = hits
    @walks = walks
    @at_bats = at_bats
  end
  
  def batting_average
    return @hits.to_f/@at_bats
  end

  def on_base_percentage
    return (@hits + @walks).to_f/@at_bats
  end
end

rodrigo = BaseballPlayer.new(10, 4, 50)
puts rodrigo.batting_average
puts rodrigo.on_base_percentage
puts rodrigo.hits

# require 'open-uri'
# remote_base_url = "http://en.wikipedia.org/wiki"

# [1900, 1910, 'xj3490', 2000].each do |yr|
 
#  retries = 3
 
#  begin
#    url = "#{remote_base_url}/#{yr}"
#    puts "Getting page #{url}"
#    rpage = open(url)
#  rescue StandardError=>e
#    puts "\tError: #{e}"
#    if retries > 0
#        puts "\tTrying #{retries} more times"
#        retries -= 1
#        sleep 1
#        retry
#    else
#        puts "\t\tCan't get #{yr}, so moving on"
#    end    
#  else
#    puts "\tGot page for #{yr}"
#  ensure   
#    puts "Ensure branch; sleeping"
#    sleep 1

#  end
# end

# a = 10
# b = 43

# begin
#   a + b

# rescue
#   puts "Could not add variables a (#{a.class}) and b (#{b.class})."
# else
#   puts "a + b is #{a + b}"
# end

# class Viking
#   def initialize(name, health, age, strength)
#       #... set variables
#       @name = name
#       @health = health
#       @age = age
#       @strength = strength
#   end
#   def self.create_warrior(name)
#       age = rand * 20 + 15   # remember, rand gives a random 0 to 1
#       health = [age * 5, 120].min
#       strength = [age / 2, 10].min
#       Viking.new(name, health, age, strength)  # returned
#   end

#   def self.random_name
#     ["Erik", "Lars", "Leif"].sample
#   end

#   def self.silver_to_gold(silver_pieces)
#     silver_pieces/10
#   end

#   class << self
#     def gold_to_silver(gold_pieces)
#       gold_pieces * 10
#     end
#   end
# end

# sten = Viking.create_warrior('Sten')
# puts sten.inspect()
# warrior1 = Viking.create_warrior(Viking.random_name)
# puts warrior1.inspect()


# class Array
#   def my_each(some_method)
#     i = 0
#     while i < self.size
#       some_method.call(self[i])
#       i+=1
#     end
#     self
#   end
# end

# def print_stuff(word)
#   print "#{word}"
# end

# [1,2,3].my_each(method(:print_stuff)).inspect

# https://www.eriktrautman.com/posts/ruby-explained-blocks-procs-and-lambdas-aka-closures
# class Array
#   def my_each
#     i = 0
#     while i < self.size
#       yield(self[i]) if block_given? 
#       i += 1
#     end
#     self
#   end
# end

# dudes = ["Mike", "Bob", "Joe"]
# dudes.my_each { |num| print "#{num}"}

# dudes.my_each

# Program Logger. Write a method called log, which takes a string description of a
#  block and, of course, a block. Similar to  doSelfImportantly, it should puts a 
#  string telling that it has started the block, and another string at the end telling 
#  you that it has finished the block, and also telling you what the block returned. 
#  Test your method by sending it a code block. Inside the block, put another call to log,
#   passing another block to it. (This is called nesting.) In other words, your output should
#    look something like this:

# Beginning "outer block"...
# Beginning "some little block"...
# ..."some little block" finished, returning:  5
# Beginning "yet another block"...
# ..."yet another block" finished, returning:  I like Thai food!
# ..."outer block" finished, returning:  false

# def log (descriptionOfBlock, &block)
#     puts "starting block: #{descriptionOfBlock}"
#     value_returned = block.call
#     puts "finished block #{descriptionOfBlock}"
#     puts value_returned
# end

# log ('outer block') do
#     log ('inner block') {
#          5
#     }
# end


# def log block_description, &block
#     puts 'Beginning "'+block_description+'" . . .' 
#     value_returned = block.call
#     puts '. . . "'+block_description+'" finished, returning:'
#     puts value_returned
#     end
    
#     log 'outer block' do
    
#     log 'some little block' do
#     5
#     end
    
#     log 'yet another block' do
#     'I like Thai food!'
#     end
    
#     false
#     end





# Grandfather Clock. Write a method which takes a block and calls it once for 
# each hour that has passed today. That way, if I were to pass in the block do 
#     puts 'DONG!' end, it would chime (sort of) like a grandfather clock. 
#     Test your method out with a few different blocks (including the one I just gave you). 
#     Hint: You can use  Time.now.hour to get the current hour. 
#     However, this returns a number between 0 and 23, so you will
#      have to alter those numbers in order to get ordinary clock-face numbers (1 to 12).

# def hourlyDong &block
#     hours = Time.now.hour
#     for i in 1..hours do
#         block.call
#     end

# end

# hourlyDong do
#     puts 'DONG!'
# end




# def profile descriptionOfBlock, &block
#     startTime = Time.now
#     block.call
#     duration = Time.now - startTime
#     puts descriptionOfBlock + ': ' + duration.to_s + ' seconds'
# end

# profile '25000 doublings' do
#     number = 1

#     25000.times do
#         number = number + number
#     end


#     puts number.to_s.length.to_s + ' digits'
# end

# profile 'count to a million' do 
#     number = 0
#     1000000.times do
#         number += 1
#     end
# end



# class Array
#     def eachEven(&wasABlock_nowAProc)
#         isEven = true

#         self.each do |object|
#             if isEven
#                 wasABlock_nowAProc.call object
#             end

#             isEven = (not isEven)
#         end
#     end
# end

# ['apple', 'bad apple', 'cherry', 'durian'].eachEven do |fruit|
#     puts "Yum! I just love #{fruit} pies, don't you?"
# end

# [1,2,3,4,5].eachEven do |oddBall|
#     puts oddBall.to_s + ' is NOT an even number!'
# end




# def compose proc1, proc2
#     Proc.new do |x|
#         proc2.call(proc1.call(x))
#     end
# end

# squareIt = Proc.new do |x|
#     x*x
# end

# doubleIt = Proc.new do |x|
#     x + x
# end

# doubleThenSquare = compose doubleIt, squareIt
# squareThenDouble = compose squareIt, doubleIt

# puts doubleThenSquare.call (5)
# puts squareThenDouble.call (5)




# def doUntilFalse firstInput, someProc
#     input = firstInput
#     output = firstInput

#     while output
#         input = output
#         output = someProc.call input
#     end

#     input
# end

# buildArrayOfSquares = Proc.new do |array|
#     lastNumber = array.last
#     if lastNumber <= 0
#         false
#     else
#         array.pop
#         array.push lastNumber*lastNumber
#         array.push lastNumber - 1
#     end
# end

# alwaysFalse = Proc.new do |justIgnoreMe|
#     false
# end

# puts doUntilFalse([5], buildArrayOfSquares).inspect
# puts doUntilFalse("I'm writing this at 3:00 am; someone knock me out!", alwaysFalse)







# def doSelfImportantly someProc
#     puts "Everybody just HOLD ON! I have something to do..."
#     someProc.call
#     puts "OK everyone. I'm done. Go on with what you were doing."
# end

# sayHello = Proc.new do 
#     puts "Goodbye horses."
# end

# sayGoodbye = Proc.new do
#     puts "We're flying over youuuuuu."
# end

# doSelfImportantly sayHello
# doSelfImportantly sayGoodbye





# class OrangeTree
#     def initialize
#         @height = 1
#         @oranges = 0
#     end

#     def height
#         @height
#     end

#     def countTheOranges
#         @oranges
#     end

#     def pickAnOrange
#         if @oranges < 1
#             puts "No oranges to pick."
#         else
#             @oranges -= 1
#             puts "Yum. That orange was delicious."
#         end
#     end

#     def waterTree
#         oneYearPasses
#         puts "Time passes like a river. The tree is now #{@height} feet tall. 
#                 Which, conveniently corresponds to its age!"
#     end

#     private
    
#     def oneYearPasses
#         @height += 1
#         if height > 15
#             puts "The tree dies after #{@height} years. It was a good life."
#             exit
#         end
#         if height > 3
#             @oranges = 6
#         end
#     end
# end

# tree = OrangeTree.new
# puts tree.height
# puts tree.countTheOranges
# tree.pickAnOrange
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree
# puts tree.countTheOranges
# puts tree.height
# tree.pickAnOrange

# tree.pickAnOrange
# tree.pickAnOrange
# tree.pickAnOrange
# tree.pickAnOrange
# tree.pickAnOrange
# tree.pickAnOrange
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree
# tree.waterTree



# class Dragon
#     def initialize name
#         @name = name
#         @sleep = false
#         @stuffInBelly = 10
#         @stuffInIntestine = 0

#         puts "#{@name} is born."
#     end

#     def feed
#         puts "You feed #{@name}."
#         @stuffInBelly = 10
#         passageOfTime
#     end

#     def walk
#         puts "You walk #{@name}."
#         @stuffInIntestine = 0
#         passageOfTime
#     end

#     def putToBed
#         puts "You put #{@name} to bed."
#         @asleep = true
#         3.times do 
#             if @asleep
#                 passageOfTime
#             end
#             if @asleep
#                 puts "#{@name} snores, filling the room with smoke."
#             end
#         end
#         if @asleep
#             @asleep = false
#             puts "#{@name} wakes up slowly."
#         end
#     end

#     def toss
#         puts "You toss #{@name} up into the air."
#         puts "He giggles, which singes your eyebrows."
#         passageOfTime
#     end

#     def rock
#         puts "You rock #{@name} gently."
#         @asleep = true
#         puts "He briefly dozes off."
#         passageOfTime
#         if @asleep
#             @asleep = false
#             puts "... but wakes when you stop."
#         end
#     end

#     private

#     def hungry?
#         @stuffInBelly <= 2
#     end

#     def poopy?
#         @stuffInIntestine >= 8
#     end

#     def passageOfTime
#         if @stuffInBelly > 0
#             @stuffInBelly -= 1
#             @stuffInIntestine += 1
#         else
#             if @asleep
#                 @asleep = false
#                 puts "He wakes up suddenly!"
#             end
#             puts "#{@name} is starving. In desperation, he eats YOU!"
#             exit
#         end

#         if @stuffInIntestine >= 10
#             @stuffInIntestine = 0
#             puts "Whoops! #{@name} had an accident..."
#         end

#         if poopy?
#             if @asleep
#                 @asleep = false
#                 puts "He wakes up suddenly."
#             end
#             puts "#{@name} does the potty dance."
#         end
#     end
# end

# pet = Dragon.new "Norbert"
# pet.feed
# pet.toss
# pet.walk
# pet.putToBed
# pet.rock
# pet.putToBed
# pet.putToBed
# pet.putToBed
# pet.putToBed
# puts "test"
# pet.feed



# class Die
#     def initialize
#         roll
#     end

#     def roll
#         @numberShowing = 1 + rand(6)
#     end

#     def cheat
#         puts "What side should show?"
#         selection = gets.chomp

#         if (selection.to_i > 0 and selection.to_i <= 6)
#             puts "Setting the side to #{selection}."
#             @numberShowing = selection.to_i
#         else
#             puts "Invalid input."
#         end
#     end
    

#     def showing
#         @numberShowing
#     end
# end

# the_die = Die.new
# puts the_die.showing

# the_die.cheat

# puts the_die.showing




# def spank birthday
#     today = Time.new
#     years_passed = ((today - birthday) / 60 / 60 / 24 / 365.25).round

#     puts "#{years_passed}? Wow. You've been a bad human"
#     gets.chomp
    
#     years_passed.times do
#         puts "SPANK!"
#     end
# end

# puts "Tell me your birth year"
# year = gets.chomp

# puts "Tell me your birth month (numeric)"
# month = gets.chomp

# puts "Tell me your birth day"
# day = gets.chomp

# spank Time.mktime(year,month,day)






# def sayMoo numberOfMoos
#     puts 'moooooooo...'*numberOfMoos
#     'ca'
#     return 'yellow submarine'
# end

# x = sayMoo 3
# puts x




# Let's write a program which asks us to type in as
#  many words as we want (one word per line, continuing
#   until we just press Enter on an empty line), and which
#      then repeats the words back to us in alphabetical order. OK?

# puts "Add something to the array"
# something_to_add = gets.chomp
# storage = []

# while something_to_add != ''
#     storage.push(something_to_add)
#     puts "Add something to the array"
#     something_to_add = gets.chomp
# end
# 
# puts storage.sort






# puts "Say something to Grandma."
# statement = gets.chomp
# bye_count = 0

# while statement != "BYE" or bye_count < 2
#     if (statement == "BYE")
#         bye_count += 1
#         puts "Bye count: #{bye_count}"
#     else
#         bye_count = 0
#         puts "Bye count: #{bye_count}"
#     end
#     if (statement != statement.upcase)
#         puts "HUH?!  SPEAK UP, SONNY!"
#     else
#         puts "NO, NOT SINCE #{1930 + rand(20)}!"
#     end
#     puts "Say something to Grandma."
#     statement = gets.chomp
# end