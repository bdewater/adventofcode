require 'set'

class BoardingPass
  attr_reader :row, :column

  def self.lower_half(range)
    new_size = (range.size / 2)
    range.first..(range.last - new_size)
  end

  def self.upper_half(range)
    new_size = (range.size / 2)
    (range.first + new_size)..range.last
  end

  def self.decode(code, initial_range)
    range = initial_range
    code.chars.each do |char|
      range = case char
        when 'F', 'L'
          lower_half(range)
        when 'B', 'R'
          upper_half(range)
      end
    end
    range.first
  end

  def initialize(code)
    /(?<row_code>[FB]{7})(?<column_code>[LR]{3})/ =~ code
    @row = self.class.decode(row_code, 0..127)
    @column = self.class.decode(column_code, 0..7)
  end

  def seat
    (row * 8) + column
  end

  def self.check_part_1(codes)
    codes
      .map { |code| BoardingPass.new(code).seat }
      .max
  end

  def self.check_part_2(codes)
    taken_seats = codes.map { |code| BoardingPass.new(code).seat }.sort
    possible_seats = (taken_seats.min..taken_seats.max).to_a
    possible_seats - taken_seats
  end
end

if __FILE__ == $0
  filename = "05_input.txt"
  input = File.read(filename).split("\n")
  puts "Part 1: #{BoardingPass.check_part_1(input)}"
  puts "Part 2: #{BoardingPass.check_part_2(input)}"
end
