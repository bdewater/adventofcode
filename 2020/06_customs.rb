require 'set'

class Customs
  def self.check_part_1(input)
    input
      .split("\n\n")
      .map { |group| Set.new(group.tr("\n", "").chars) }
      .sum { |group| group.size }
  end

  def self.check_part_2(input)
    input
      .split("\n\n")
      .sum do |group|
        persons = group.split("\n")
        counts = persons.each_with_object(Hash.new(0)) do |person, count|
          person.each_char { |answer| count[answer] += 1 }
        end
        # counts = persons
        #   .map(&:each_char)
        #   .map(&:tally)
        #   .inject { |memo, el| memo.merge(el) { |_key, old_v, new_v| old_v + new_v } }
        counts.keep_if { |_, v| v == persons.size }.keys.size
    end
  end
end

if __FILE__ == $0
  filename = "06_input.txt"
  input = File.read(filename)
  puts "Part 1: #{Customs.check_part_1(input)}"
  puts "Part 2: #{Customs.check_part_2(input)}"
end
