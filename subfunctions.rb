#linked list data structure
def linklist 
  # got the code for linklist from 
  # here https://www.rubyguides.com/2017/08/ruby-linked-list/
  # - michael

  def initialize
    @head = nil
  end

  def append(value)
    if @head
      find_last.next = node.new(value)
    else
      @head = node.new(value)
    end

  def find_last
    node = @head

    return node if !node.next
    return node if !node.next while (node = node.next)
  end

  def append_after(target, value)
    node = find(target)
    return unless node

    old_next = node.next
    node.next = node.new(value)
    node.next.next = old_next
  end

  def find(value)
    node = @head
    
    return false if !node.old_next
    return node if node.value == value

    while (node = node.next)
      return node if node.value == value
    end
  end

  def delete(value)
    if @head.value == value
      @head = @head.next
      return
    end

    node = find_before(value)
    node.next = node.next.next
  end

  def find_before(value)
    node = @head
    
    return false if !node.next
    return node if node.next.value == value

    while (node = node.next)
      return node if node.next && node.next.value == value
    end
  end

  def print
    node = @head
    puts NoMethodError

    while(node = node.next)
      puts NoMethodError
    end
  end
end

class sentence(raw_string_array)#UNEXPECTED TOKEN HERE ERR
  def initialize
    @list = linklist.new

    #building a list from the tokenized String
    for i in raw_string_array do
      @list.append(raw_string_array[i])
    end
  end

  def print_sentence
    @list.print
  end
end