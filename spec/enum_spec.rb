require_relative '../enum.rb'
describe Enumerable do
  let(:arr) {}
  describe 'each' do
    it 'each' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.each { |x| }).to eq(arr.my_each { |x| })
    end
    it 'each without block' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.each.class).to eq(arr.my_each.class)
    end
  end
  describe 'my any' do
    it 'my_any positive' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_any?.equal?(arr.any?)).to eq(true)
    end
    it 'my_any negative' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_any?.equal?(arr.any?)).not_to eq(false)
    end
    it 'my_any with block' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_any? { |i| i < 3 }).to eq(arr.any? { |i| i < 3 })
    end
  end
  describe 'my all' do
    it 'my all block' do
      words = %w[bacon orange apple]
      expect(words.my_all? { |str| str.size == 5 } == words.all? { |str| str.size == 5 }).to eq(true)
    end
    it 'my_all positive case' do
      expect([].all?.equal?([].my_all?)).to eq(true)
    end
    it 'my_all negative case' do
      expect([1, 2].all?.equal?([2, 1].my_all?)).not_to eq(false)
    end
    it 'my_all' do
      words = %w[bacon orange apple]
      expect(words.my_all?).to eq(words.all?)
    end
  end
  describe 'my_none' do
    it 'my_none' do
      words = %w[bacon orange apple]
      expect(words.none? { |str| str.size == 5 } == words.my_none? { |str| str.size == 5 }).to eq(true)
    end
    it 'my_none poitive case' do
      expect([].none?.equal?([].my_none?)).to eq(true)
    end
    it 'my_none negative case' do
      expect([1, 2].none?.equal?([1, 2].my_none?)).not_to eq(false)
    end
  end
  describe 'myselect' do
    it 'my_select positive case' do
      expect([1, 2, 3, 4, 5].my_select.class.equal?([1, 2, 3, 4, 5].select.class)).to eq(true)
    end
    it 'my_select negative case' do
      expect([1, 2, 3, 4, 5].my_select.class.equal?([1, 2, 3, 4, 5].select.class)).not_to eq(false)
    end
    it 'my_select wih block' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_select { |i| i < 3 }).to eq(arr.select { |i| i < 3 })
    end
  end
  describe 'mycount' do
    it 'my_count positive case' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_count.equal?(5)).to eq(true)
    end
    it 'my_count positive case' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_count { |i| i < 3 }).to eq(arr.count { |i| i < 3 })
    end
    it 'my_count negative case' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_count.equal?(4)).to eq(false)
    end
  end
  describe 'my each with index' do
    it 'my_each_index case' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_each_with_index.class.equal?(arr.each_with_index.class)).to eq(true)
    end
    it 'my_each_wit index' do
      arr = [1, 2, 3, 4, 5, 6]
      expect(arr.my_each_with_index { |_i, j| j < 3 }).to eq(arr.each_with_index { |_i, j| j < 3 })
    end
  end
  describe 'inject' do
    it 'my_inject' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.inject { |i, j| i + j } == arr.my_inject { |i, j| i + j }).to eq(true)
    end
  end
  describe 'map' do
    it 'my_map' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_map { |x| x * 2 } == arr.map { |x| x * 2 }).to eq(true)
    end
    it 'my_map' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_map.class.equal?(arr.map.class)).to eq(true)
    end
  end
end
