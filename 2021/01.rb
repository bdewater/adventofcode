require "minitest/autorun"

class SonarSweep
def self.part_1(report)
  report.each.with_index.reduce(0) do |sum, (current_depth, index)|
    previous_depth = report[index - 1]
    if index > 0 && previous_depth < current_depth
      sum +=1
    end
    sum
  end
end

def self.part_2(report)
  report.each.with_index.reduce(0) do |sum, (_current_depth, index)|
    if index.between?(3, report.length)
      previous_window = report.slice(index - 3, 3).sum
      current_window = report.slice(index - 2, 3).sum
      if previous_window < current_window
        sum +=1
      end
    end
    sum
  end
end
end

class SonarSweepTest < Minitest::Test
  EXAMPLE_INPUT = %w(
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
  ).map(&:to_i)
  ANSWER_INPUT = File.readlines("01_input.txt", chomp: true).map(&:to_i)

  def test_example_1
    assert_equal(7, SonarSweep.part_1(EXAMPLE_INPUT))
  end

  def test_answer_1
    assert_equal(1581, SonarSweep.part_1(ANSWER_INPUT))
  end

  def test_example_2
    assert_equal(5, SonarSweep.part_2(EXAMPLE_INPUT))
  end

  def test_answer_2
    assert_equal(1618, SonarSweep.part_2(ANSWER_INPUT))
  end
end
