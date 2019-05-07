file = File.open("sample.txt", "r").readlines.each do |line|
  puts line
end

# require "open-uri"

# remote_base_url = "http://en.wikipedia.org/wiki"
# remote_page_name = "Ada_Lovelace"
# remote_full_url = remote_base_url + "/" + remote_page_name

# remote_data = open(remote_full_url).read
# my_local_file = open("my-downloaded-page.html", "w")
# my_local_file.write(remote_data)
# my_local_file.close

# fname = "sample.txt"
# somefile = File.open(fname, "w")
# somefile.puts "hello file"
# somefile.close

# require 'yaml'

# class Person
#   attr_accessor :name, :age, :gender

#   def initialize(name, age, gender)
#     @name = name
#     @age = age
#     @gender = gender

#   end

#   def to_yaml
#     YAML.dump ({
#       :name => @name,
#       :age => @age,
#       :gender => @gender
#     })
#   end

#   def self.from_yaml(string)
#     data = YAML.load string
#     p data
#     self.new(data[:name], data[:age], data[:gender])
#   end
# end

# p = Person.new "David", 28, "male"
# p p.to_yaml

# p = Person.from_yaml(p.to_yaml)
# puts "Name #{p.name}"
# puts "Age #{p.age}"
# puts "Gender #{p.gender}"