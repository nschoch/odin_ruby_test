require './bubblesort.rb'

describe '#bubble_sort' do
  it 'sort array' do
    expect(bubble_sort([0,3,5,7,3,1])).to eql([0,1,3,3,5,7])
  end
end