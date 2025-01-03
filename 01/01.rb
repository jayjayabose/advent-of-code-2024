module DataReader
    FILE_NAME = '01_input.txt'

    def self.get_lists
        array_one = []
        array_two = []

        lines = File.readlines(FILE_NAME)

        lines.each do |line|
            one, two = line.split
            array_one << one.to_i
            array_two << two.to_i
        end

        [array_one, array_two]
    end
end

def total_distance(list_one, list_two)
    list_one = list_one.sort
    list_two = list_two.sort

    list_one.each_with_index.reduce(0) do |sum, (num, i)|
        sum + (num - list_two[i]).abs
    end
end

array_one, array_two = DataReader.get_lists
puts total_distance(array_one, array_two)