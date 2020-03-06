module Enumerable
  def error_msg
    puts "wrong block"
  end
  def my_each
    if !block_given?
      error_msg
      return
    end
    for el in self
      yield el
    end
  end
  def my_each_with_index
    if !block_given?
      error_msg
      return
    end
    i = 0
    self.my_each do |element|
      puts(i.to_s + " index has " + element.to_s)
      i = yield i
    end
  end
  def my_select
    if !block_given?
      error_msg
      return
    end
    self.each do |i|  
      result=yield i
      next unless result == true
      puts i
    end
  end
  def my_all?
    if !block_given?
      error_msg
      return
    end
    
    self.my_each do |i|
      result = yield i
      next unless result == false
      return false
    end
    true
  end
  def my_none?
    if !block_given?
      error_msg
      return
    end
    self.my_each do |i|
      result=yield i
      next unless result == true
      return false
    end
    true
  end
  def my_any?
    if !block_given?
      error_msg
      return
    end
    self.my_each do |i|
        res=yield i
        next unless res == true
        return true
    end
    false
  end
  def my_count
    if block_given?
      error_msg
      return
    end
    i = 0
    self.my_each do |a|
      i += 1
    end
    i
  end
  def my_map
    if !block_given?
      error_msg
      return
    end
    i = 0
    while i < self.length
      self[i] = yield self[i]
      i += 1
    end
    self
  end
  def my_inject
    if !block_given?
      error_msg
      return
    end
    res=1
    self.my_each do |i|
        res = yield i,res
    end
    res
  end
end

arr = [1, 2, 3, 4, 5]
def multiply_els(arr)
  v = arr.my_inject do |i,j|
    i * j
  end
  puts v
end

arr = arr.my_map do |x|
  x *= 2
end
multiply_els(arr)
=begin
val = %w[this is tahir].my_none? do |i|
  if i.length == 3
    true
  else
    false
  end
end
arr.my_each_with_index do |x|
    x += 1
end
arr.my_select do |x|
  if x >= 3
    true
  else
    false
  end
end


=end
