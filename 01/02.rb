require_relative 'data_reader'

def calculate_similarity_score(list_one, list_two)
    list_two_locations = Hash.new(0)
    list_two.each { |location| list_two_locations[location] += 1 }

    list_one.reduce(0) do |sum, location|
        sum + (location * list_two_locations[location])
    end
end

test_one, test_two = DataReader::get_test_lists
puts calculate_similarity_score(test_one, test_two) == 31

array_one, array_two = DataReader::get_lists
puts calculate_similarity_score(array_one, array_two)
  