require "minitest/autorun"

class Submarine1
  attr_reader :horizontal, :depth

  def initialize
    @horizontal = 0
    @depth = 0
  end

  def forward(x)
    @horizontal += x
  end

  def down(x)
    @depth += x
  end

  def up(x)
    @depth -= x
  end
end

class Submarine2
  attr_reader :horizontal, :depth, :aim

  def initialize
    @horizontal = 0
    @depth = 0
    @aim = 0
  end

  def forward(x)
    @horizontal += x
    @depth += aim * x
  end

  def down(x)
    @aim += x
  end

  def up(x)
    @aim -= x
  end
end

class SubmarineTest < Minitest::Test
  EXAMPLE_INPUT = [
    "forward 5",
    "down 5",
    "forward 8",
    "up 3",
    "down 8",
    "forward 2",
  ]
  ANSWER_INPUT = File.readlines("02_input.txt", chomp: true)

  def test_example_1
    assert_equal(150, process_instructions(Submarine1.new, EXAMPLE_INPUT))
  end

  def test_answer_1
    assert_equal(2039256, process_instructions(Submarine1.new, ANSWER_INPUT))
  end

  def test_example_2
    assert_equal(900, process_instructions(Submarine2.new, EXAMPLE_INPUT))
  end

  def test_answer_2
    assert_equal(1856459736, process_instructions(Submarine2.new, ANSWER_INPUT))
  end

  def process_instructions(sub, instructions)
    instructions.each do |instruction|
      direction, units = instruction.split(" ")
      sub.send(direction, units.to_i)
    end
    sub.horizontal * sub.depth
  end
end
