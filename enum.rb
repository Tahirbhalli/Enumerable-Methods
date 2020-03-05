module Enum
  def my_each(arr)
    for el in arr
      yield el
    end
  end
  def my_each_with_index(arr)
    i = 0
    while i < arr.length
      puts arr[i].to_s + " on index " + i.to_s
      i += 1
    end
  end
  def my_select(arr)
    arr.each do |i|
      result=yield i
      next unless result == true
      puts i
    end
  end
end
include Enum
arr=[1, 2, 3, 4, 5]
Enum.my_select(arr) do |num|
  if num > 3
    true
  else
    false 
  end 
end
=begin
Enum.my_each(arr) do |x|
  puts x
end
Enum.my_each_with_index(arr)
=end
