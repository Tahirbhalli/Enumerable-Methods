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

  def my_all?(proc=nil)
    ar = self
    if proc
      return ar.all?(proc)
    end
    if block_given?
      ar.my_each do |i|
        next unless (yield i) == false
  
        return false
      end
    end
    return true if ar.my_count == 0
    !!ar[0]
  end

  def my_none?(proc=nil)
    ar = self
    if proc
      return ar.none?(proc)
    end
    if block_given?
      ar.my_each do |i|
        next unless (yield i) == true

        return false
      end
    end
    return !ar[ar.length - 1]
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

    true
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
    return unless block_given?

    ar = self
    new_arr = []
    ar.my_each do |j|
      a = yield j
      new_arr.append(a)
    end
    new_arr
  end

  def my_inject(proc = nil)
    return unless block_given?

    ar = self
    res = yield self[0], self[1]

    (ar.length - 2).times do |i|
      res = yield self[i + 2], res
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

#puts arr.my_none?(Float)


p [nil, true, 99].my_all? == [nil, true, 99].all?
p [].all? == [].my_all?
p [].none? == [].my_none?
p [nil].my_none? == [nil].my_none?
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
