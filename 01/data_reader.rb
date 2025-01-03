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

    def self.get_test_lists
        test_one = [3, 4, 2, 1, 3, 3]
        test_two = [4, 3, 5, 3, 9, 3]

        [test_one, test_two]
    end
end