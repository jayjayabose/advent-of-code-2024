# require 'Report'
require "pry"
require "./lib/02/02_01"

describe ReportCreator do
  describe "#create_reports" do
    it "creates reports from data" do
      data = "1 2 3\n2 3 4\n3 4 5"
      creator = described_class.new(data: data)

      expect(Report).to receive(:new).with(levels: [1, 2, 3]).once
      expect(Report).to receive(:new).with(levels: [2, 3, 4]).once
      expect(Report).to receive(:new).with(levels: [3, 4, 5]).once

      creator.create_reports
    end
  end
end

describe Report do
  describe "#safe?" do
    it "is false when only one level" do
      report = described_class.new(levels: [1])
      expect(report.safe?).to be(false)
    end

    it "is false when no levels" do
      report = described_class.new(levels: [])
      expect(report.safe?).to be(false)
    end

    it "is false when a level is same as the prior level" do
      report = described_class.new(levels: [1, 2, 2])

      expect(report.safe?).to be(false)
    end

    it "is false when a level is greater than the prior level by four or more" do
      report = described_class.new(levels: [1, 2, 7])

      expect(report.safe?).to be(false)
    end

    it "is false when a level is less than the prior level by four or more" do
      report = described_class.new(levels: [7, 2, 1])

      expect(report.safe?).to be(false)
    end

    it "is true when levels increase only within allowable range" do
      report = described_class.new(levels: [1, 3, 6, 7, 9])

      expect(report.safe?).to be(true)
    end

    it "is true when levels decrease only within allowable range" do
      report = described_class.new(levels: [9, 7, 6, 3, 1])

      expect(report.safe?).to be(true)
    end

    it "is false when increasing levels change direction" do
      report = described_class.new(levels: [1, 2, 3, 2])

      expect(report.safe?).to be(false)
    end

    it "is false when decreasing levels change direction" do
      report = described_class.new(levels: [3, 2, 1, 2])

      expect(report.safe?).to be(false)
    end
  end
end
