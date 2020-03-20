require_relative '../enum.rb'
describe 'Enumerable' do
  it 'enum testing' do
    arr = [1, 2, 3, 4, 5]
    arr.my_any?.equal? arr.any?
  end
  it 'enum testing' do
    [1, 2, 3, 4, 5].my_select.class.equal? [1, 2, 3, 4, 5].select.class
  end
  it 'enum testing' do
    [nil, false, nil, false].my_any?.equal? [nil, false, nil, false].any?
  end
  it 'enum testing' do
    [].none?.equal? [].my_none?
  end
  it 'enum testing' do
    [].all?.equal? [].my_all?
  end
  it 'enum testing' do
    true_array = [nil, false, true, []]
    true_array.my_any?.equal? true_array.any?
  end
end
