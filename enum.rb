module Enumerable
  def error_msg
    puts 'wrong block'
  end

  def my_each
    if block_given?
      ar = self
      ar.each do |el|
        yield el
      end
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      ar = self
      ar.my_each do |element|
        yield i, element
        i += i
      end
    else
      return
    end
    
  end

  def my_select
    if block_given?
      ar = self
      new_arr = []
      ar.my_each do |i|
        next unless (yield i) == true
        new_arr.append(i)
      end
      new_arr
    else
      return
    end
    
  end

  def my_all?
    unless block_given?
      return
    end
    ar = self
    ar.my_each do |i|
      next unless (yield i) == false

      return false
    end
    true
  end

  def my_none?
    unless block_given?
      return
    end
    ar = self
    ar.my_each do |i|
      next unless (yield i) == true

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
      next unless (yield i) == true

      return true
    end
    false
  end

  def my_count
    if block_given?
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


p arr.my_inject { |i, j| i * j } == arr.my_inject { |i, j| i * j }
p arr.my_map{|x| x * 2} == arr.map{|x| x * 2}
p arr.count==arr.my_count
p arr.my_any?{|x| x >= 0} == arr.any?{|x| x >= 0}
p arr.my_none?{|x| x >= 0} == arr.none?{|x| x >= 0}
p arr.my_all?{|x| x >= 0} == arr.all?{|x| x >= 0 }
p arr.my_select {|x| x >= 3} == arr.select {|x| x >= 3}
p arr.my_each_with_index {} == arr.each_with_index {}
p arr.my_each{|x|} == arr.each{|x|}