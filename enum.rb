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
    return true if !ar.member? nil or ar.include? true

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

  def my_map(proc = nil)
    ar = self
    new_arr = []
    unless proc.nil?
      ar.each do |x|
        return false unless proc.yield x
      end
      return true
    end
    return to_enum unless block_given? && proc.nil?

    ar.my_each do |j|
      a = yield j
      new_arr.append(a)
    end
    new_arr
  end

  def my_inject(proc = nil, ope = nil)
    return inject(proc) if ope == nil?
    return inject(proc, ope) unless ope.nil?

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

puts [1, 1, 1].inject(:+)

my_proc = proc { |num| num.positive? }

arr = [1, 2, 2, 4, 5]
va = arr.my_map(my_proc)
puts va
def multiply_els(arr)
  v = arr.my_inject do |i, j|
    i * j
  end
  puts v
end
