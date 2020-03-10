module Enumerable
  def my_each
    return to_enum unless block_given?

    ar = self
    ar.each do |el|
      yield el
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    ar = self
    ar.my_each do |element|
      yield element, i
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    ar = self
    new_arr = []
    ar.my_each do |i|
      next unless (yield i) == true

      new_arr.append(i)
    end
    new_arr
  end

  def my_all?(proc = nil)
    ar = self
    return ar.all?(proc) if proc

    if block_given?
      ar.my_each do |i|
        next unless (yield i) == false

        return false
      end
      return true
    end

    return false if ar.include? false or ar.include? nil

    true
  end

  def my_none?(proc = nil)
    ar = self
    return ar.none?(proc) if proc

    if block_given?
      ar.my_each do |i|
        next unless (yield i) == true

        return false
      end
      return true
    end
    !ar[ar.length - 1]
  end

  def my_any?(proc = nil)
    ar = self
    return ar.any?(proc) if proc

    if block_given?
      ar.my_each do |i|
        next unless (yield i) == true

        return true
      end
      return false
    end
    return true if !ar.member? nil or !ar.member? false

    false
  end

  def my_count(proc = nil)
    ar = self
    i = 0
    if proc
      ar.my_each do |x|
        next unless x == proc

        i += 1
      end
      return i
    end
    if block_given?
      ar.my_each do |x|
        next unless (yield x) == true

        i += 1
      end
      return i
    end

    ar.my_each do
      i += 1
    end
    i
  end

  def my_map
    return to_enum unless block_given?

    ar = self
    new_arr = []
    ar.my_each do |j|
      a = yield j
      new_arr.append(a)
    end
    new_arr
  end

  def my_inject(proc = nil, ope = nil)
    return inject(proc, ope) unless ope.nil?
    return true if proc

    ar = to_a
    res = yield ar[0], ar[1]

    j = 0
    ar.each do |i|
      j += 1
      next if j <= 2

      res = yield i, res
    end
    return yield res, proc if proc

    res
  end
end

arr = [1, 2, 2, 4, 5]
def multiply_els(arr)
  v = arr.my_inject do |i, j|
    i * j
  end
  puts v
end
multiply_els(arr)

p arr.each.class == arr.my_each.class
p [5, 6, 7, 8, 9, 10].my_inject(4) { |prod, n| prod * n } == [5, 6, 7, 8, 9, 10].inject(4) { |prod, n| prod * n }

p [1, 2, 3, 4, 5].my_select.class == [1, 2, 3, 4, 5].select.class # Enumerator and Enumerator+0cxajsdhkjahd(addr)
p arr.my_each_with_index.class == arr.each_with_index.class # Enumerator and Enumerator+0cxajsdhkjahd(addr)

p [1, 2, 3, 4, 5].my_any? { |num| num > 5 } == [1, 2, 3, 4, 5].any? { |num| num > 5 }
p [1, 2, 3, 4, 5].my_none? { |num| num > 5 } == [1, 2, 3, 4, 5].none? { |num| num > 5 }

true_array = [nil, false, true, []]
false_array = [nil, false, nil, false]
puts false_array.none? # true
puts true_array.none? # false
p [].all? == [].my_all?
puts [].my_all?
true_array = [nil, false, true, []]
false_array = [nil, false, nil, false]
p false_array.none? == false_array.my_none?
p true_array.none? == true_array.my_none?

true_array = [1, false, 'hi', []]

p true_array.my_all? == true_array.all? # true

true_array = [nil, false, true, []]
p true_array.my_any? == true_array.any? # true

p [nil, true, 99].my_all? == [nil, true, 99].all?

p [].none? == [].my_none?
p [nil].my_none? == [nil].none?
p [nil, false].none? == [nil, false].my_none?
p [nil, true, 99].my_any?(Integer) == [nil, true, 99].any?(Integer)
p arr.my_count(&:even?) == arr.count(&:even?)
p arr.inject { |i, j| i + j } == arr.my_inject { |i, j| i + j }
p arr.my_map { |x| x * 2 } == arr.map { |x| x * 2 }
p arr.count == arr.my_count
p arr.my_any? { |x| x >= 0 } == arr.any? { |x| x >= 0 }
p arr.my_none? { |x| x >= 0 } == arr.none? { |x| x >= 0 }
p arr.my_all? { |x| x >= 0 } == arr.all? { |x| x >= 0 }
p arr.my_select { |x| x >= 3 } == arr.select { |x| x >= 3 }
p arr.my_each_with_index {} == arr.each_with_index {}
p arr.my_each { |x| } == arr.each { |x| }
# test cases of Tse team asked
# p (5..9).my_inject { |i, j| i * j } == (5..9).inject { |i, j| i * j }
# p (1..2).my_inject(2, :*) == (1..2).inject(2, :*)
p [nil, false, nil, false].my_any? == [nil, false, nil, false].any?
p [nil, false, nil, false].my_any? == [nil, false, nil, false].any?

my_each_output = ''
my_each_output_two = ''
block = proc { |y, x| my_each_output += "Hello: #{y}, in: #{x}\n" }
block_two = proc { |y, x| my_each_output_two += "Hello: #{y}, in: #{x}\n" }
[1, 2, 32, 32, 3, 21, 1, 23, 12].each_with_index(&block_two)
[1, 2, 32, 32, 3, 21, 1, 23, 12].my_each_with_index(&block)

p my_each_output == my_each_output_two
p [1, false].any? == [1, false].my_any?
