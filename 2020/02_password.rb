class Password
  def self.old_policy(input)
    lines = input.split("\n")
    lines.count do |line|
      _, start_range, end_range, character, password = line.match(/(\d+)-(\d+) (\w): (\w+)/).to_a

      start_range, end_range = start_range.to_i, end_range.to_i
      count = password.chars.count { |x| x == character }
      count.between?(start_range, end_range)
    end
  end

  def self.new_policy(input)
    lines = input.split("\n")
    lines.count do |line|
      _, pos_1, pos_2, character, password = line.match(/(\d+)-(\d+) (\w): (\w+)/).to_a

      pos_1, pos_2 = pos_1.to_i, pos_2.to_i
      char_1 = password[pos_1 - 1]
      char_2 = password[pos_2 - 1]

      (char_1 == character) ^ (char_2 == character)
    end
  end
end

if __FILE__ == $0
  filename = "02_input.txt"
  input = File.read(filename)
  puts "old_policy: #{Password.old_policy(input)}"
  puts "new_policy: #{Password.new_policy(input)}"
end

