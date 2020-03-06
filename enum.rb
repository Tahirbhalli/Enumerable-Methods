module Enumerable
  def error_msg
    puts 'wrong block'
  end

  def my_each
    unless block_given?
      error_msg
      return
    end
    ar = self
    ar.each do |el|
      yield el
    end
  end

  def my_each_with_index
    if block_given?
      error_msg
      return
    end
    i = 0
    ar = self
    ar.my_each do |element|
      puts(i.to_s + ' index has ' + element.to_s)
      i += i
    end
  end

  def my_select
    unless block_given?
      error_msg
      return
    end
    ar = self
    ar.each do |i|
      result = yield i
      next unless result == true

      puts i
    end
  end

  def my_all?
    unless block_given?
      error_msg
      return
    end
    ar = self
    ar.my_each do |i|
      result = yield i
      next unless result == false

      return false
    end
    true
  end

  def my_none?
    unless block_given?
      error_msg
      return
    end
    ar = self
    ar.my_each do |i|
      result = yield i
      next unless result == true

      return false
    end
    true
  end

  def my_any?
    unless block_given?
      error_msg
      return
    end
    ar = self
    ar.my_each do |i|
      res = yield i
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
    ar = self
    ar.my_each do
      i += 1
    end
    i
  end

  def my_map
    unless block_given?
      error_msg
      return
    end
    i = 0
    ar = self
    while i < ar.length
      self[i] = yield self[i]
      i += 1
    end
    self
  end

  def my_inject
    unless block_given?
      error_msg
      return
    end
    res = 1
    ar = self
    ar.length.times do |i|
      res = yield self[i], res
    end
    res
  end
end

arr = [1, 2, 3, 4, 5]
def multiply_els(arr)
  v = arr.my_inject do |i, j|
    i * j
  end
  puts v
end
multiply_els(arr)

arr.my_each do |i|
  puts i
end
arr = arr.my_map do |x|
  x * 2
end

val = %w[this is tahir].my_none? do |i|
  i.length == 3 ? true : false
end
puts val
arr.my_each_with_index

arr.my_select do |x|
  x >= 3 ? true : false
end
