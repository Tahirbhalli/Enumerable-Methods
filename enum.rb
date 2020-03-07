module Enumerable
  def my_each
    return unless block_given?

    ar = self
    ar.each do |el|
      yield el
    end
  end

  def my_each_with_index
    return unless block_given?

    i = 0
    ar = self
    ar.my_each do |element|
      yield i, element
      i += 1
    end
  end

  def my_select
    return unless block_given?

    ar = self
    new_arr = []
    ar.my_each do |i|
      next unless (yield i) == true

      new_arr.append(i)
    end
    new_arr
  end

  def my_all?
    return unless block_given?

    ar = self
    ar.my_each do |i|
      next unless (yield i) == false

      return false
    end
    true
  end

  def my_none?
    return unless block_given?

    ar = self
    ar.my_each do |i|
      next unless (yield i) == true

      return false
    end
    true
  end

  def my_any?
    return unless block_given?

    ar = self
    ar.my_each do |i|
      next unless (yield i) == true

      return true
    end
    false
  end

  def my_count
    return if block_given?

    i = 0
    ar = self
    ar.my_each do
      i += 1
    end
    i
  end

  def my_map
    return unless block_given?

    ar = self
    new_arr = []
    ar.my_each do |j|
      a = yield j
      new_arr.append(a)
    end
    new_arr
  end

  def my_inject
    return unless block_given?

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

p arr.inject { |i, j| i * j } == arr.my_inject { |i, j| i * j }
p arr.my_map { |x| x * 2 } == arr.map { |x| x * 2 }
p arr.count == arr.my_count
p arr.my_any? { |x| x >= 0 } == arr.any? { |x| x >= 0 }
p arr.my_none? { |x| x >= 0 } == arr.none? { |x| x >= 0 }
p arr.my_all? { |x| x >= 0 } == arr.all? { |x| x >= 0 }
p arr.my_select { |x| x >= 3 } == arr.select { |x| x >= 3 }
p arr.my_each_with_index {} == arr.each_with_index {}
p arr.my_each { |x| } == arr.each { |x| }
