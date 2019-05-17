class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)
    if @head == nil
      @head = new_node
      @tail = new_node
    else
      @tail.next_node = new_node
      @tail = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
  end

  def size
    counter = 0
    pointer = @head
    while pointer != nil
      counter += 1
      pointer = pointer.next_node
    end
    return counter
  end

  def at(index)
    counter = 0
    pointer = @head
    while counter < index
      counter += 1
      pointer = pointer.next_node
    end
    return pointer
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def pop
    pointer = @head
    while pointer.next_node.next_node != nil
      pointer = pointer.next_node
    end
    pointer.next_node = nil
  end

  def contains?(search_value)
    return_value = false
    pointer = @head
    while return_value == false and pointer.next_node != nil
      if pointer.value == search_value
        return_value = true
      end
      pointer = pointer.next_node
    end
    return return_value
  end


  def find(search_value)
    counter = 0
    pointer = @head
    while  pointer.next_node != nil
      if pointer.value == search_value
        return counter
      end
      pointer = pointer.next_node
      counter += 1
    end
    return false
  end

  def to_s
    final_string = ""
    cursor = @head
    while cursor != nil
      final_string += "( #{cursor.value} ) -> "
      cursor = cursor.next_node
    end
    final_string += "( nil )"
    return final_string
  end

  def insert_at(index, value)
    counter = 0
    pointer = @head
    if index == 0
      new_node = Node.new(value,@head)
      @head = new_node
    else
      while counter < index - 1
        counter += 1
        pointer = pointer.next_node
      end
      new_node = Node.new(value,pointer.next_node)
      pointer.next_node = new_node  
    end
  end

  def remove_at(index)
    counter = 0
    pointer = @head
    if index == 0
      @head = @head.next_node
    else
      while counter < index - 1
        counter += 1
        pointer = pointer.next_node
      end
      pointer.next_node = pointer.next_node.next_node  
    end
  end


end

class Node
  attr_accessor :value, :next_node

  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

a = LinkedList.new
a.append(5)
a.append(7)
a.prepend(4)
a.append(10)
a.prepend(1)
puts a.to_s

puts "Remove at"
a.remove_at(0)
puts a.to_s
