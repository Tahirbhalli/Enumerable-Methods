require_relative '../enum.rb'
describe 'Enumerable' do
  it 'enum testing' do
    arr = [1, 2, 3, 4, 5]
    arr.my_any?.equal? arr.any?
    [1, 2, 3, 4, 5].my_select.class.equal? [1, 2, 3, 4, 5].select.class
    true_array = [nil, false, true, []]
    true_array.my_any? .equal? true_array.any?
    [].all?.equal? [].my_all?
    [].none?.equal? [].my_none?
    [nil, false, nil, false].my_any?.equal? [nil, false, nil, false].any?
  end
end
