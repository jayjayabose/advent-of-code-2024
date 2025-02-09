# PROBLEM
# description:
# a report is a a list of number (aka. levels)
# each line is a report
#
# which reports are safe
#     gradually increasing
#     gradually decreasing
#
# inputs:
# i: reports, [String] - set of reports
# o: safe_count, [Number] - count of safe reports that are safe
#
# rules
#  - change is unidirectional
#  - change is constant (no zero changes)
#  - change is 1 .. 3 (4 or greater is unsafe)
#
# EXAMPLES
# 7 6 4 2 1: Safe because the levels are all decreasing by 1 or 2.
# 1 2 7 8 9: Unsafe because 2 7 is an increase of 5.
#     ^+5
# 9 7 6 2 1: Unsafe because 6 2 is a decrease of 4.
#     ^-4
# 1 3 2 4 5: Unsafe because 1 3 is increasing but 3 2 is decreasing.
#     ^ direction change
# 8 6 4 4 1: Unsafe because 4 4 is neither an increase or a decrease.
#     ^ same level
# 1 3 6 7 9: Safe because the levels are all increasing by 1, 2, or 3.
#
# DATA STRUCTURES
#
# - Reports: Array <Report>
# - Report; Array <Level>
# - Level: Number
#
# NOUNS
# Safety Checker
# has: reports
# can:
# - get_reports
# - count_safe_reports
#
#
# ALGORITHM
# pseudo code
# if levels len < 2 false
# loop through levels at 1 indes to end
#   if level violdates return false
# return true
#
#

# reads data
# creates reports
#
require_relative "../shared/file_reader"

class SafetyChecker
  include FileReader
  private attr_reader :reports, :data

  # @param reports: [Array <Report>] - list of reports``
  def initialize
    @reports = create_reports
  end

  def count_safe_reports
    reports.count { |report| report.safe? }
  end

  private

  def create_reports
    ReportCreator.new(data: get_data).create_reports
  end

  def get_data
    file = File.join(__dir__, "data.txt")
    read_to_string(file:)
  end
end

class ReportCreator
  private attr_reader :data

  # @param data: [String] - representation of reports
  def initialize(data:)
    @data = data
  end

  # @return [Array <Report>] - list of reports
  def create_reports
    data.split("\n").map do |report|
      levels = report.split(" ").map(&:to_i)
      Report.new(levels: levels)
    end
  end
end

class Report
  attr_reader :levels, :change_direction

  # @param levels: [Array <Number>] - list of levels reprsented as Numbers
  def initialize(levels:)
    @levels = levels
    @change_direction = set_change_diirection
  end

  # @return [Boolean] - true levels do not violate safety rules, otherwise false
  def safe?
    return false if levels.length < 2

    (1...levels.length).each do |idx|
      current_level = levels[idx]
      previous_level = levels[idx - 1]
      return false if safety_violation?(previous_level:, current_level:)
    end

    true
  end

  private

  def set_change_diirection
    return nil if levels.length < 2 || levels[0] == levels[1]
    (levels[1] - levels[0] > 0) ? :increasing : :decreasing
  end

  def safety_violation?(previous_level:, current_level:)
    return true if no_change_violation?(previous_level:, current_level:)
    return true if large_change_violation?(previous_level:, current_level:)
    return true if change_direction_violation?(previous_level:, current_level:)
    false
  end

  def no_change_violation?(previous_level:, current_level:)
    current_level == previous_level
  end

  def large_change_violation?(previous_level:, current_level:)
    (current_level - previous_level).abs >= 4
  end

  def change_direction_violation?(previous_level:, current_level:)
    return false if change_direction.nil?
    return true if change_direction == :increasing && previous_level > current_level
    return true if change_direction == :decreasing && previous_level < current_level
    false
  end
end

# get the answer
puts SafetyChecker.new.count_safe_reports
