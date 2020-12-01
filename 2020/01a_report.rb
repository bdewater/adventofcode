class Report
  def self.multiply(input, combination_length)
    report = input.split("\n").map(&:to_i)

    report
      .combination(combination_length)
      .find { |n| n.take(combination_length).sum == 2020 }
      .reduce(:*)
  end
end

if __FILE__ == $0
  filename = "01_input.txt"
  input = File.read(filename)
  puts Report.multiply(input)
end
