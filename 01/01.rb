require_relative 'data_reader'

def total_distance(list_one, list_two)
    list_one = list_one.sort
    list_two = list_two.sort

    list_one.each_with_index.reduce(0) do |sum, (num, i)|
        sum + (num - list_two[i]).abs
    end
end

test_one, test_two = DataReader::get_test_lists
puts total_distance(test_one, test_two) == 11

array_one, array_two = DataReader::get_lists
puts total_distance(array_one, array_two)