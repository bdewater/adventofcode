class Report
  def self.multiply(input)
    report = input.split("\n").map(&:to_i)

    permutations = report.permutation(3).to_a
    permutations.select! { |a, b, c| a + b + c == 2020 }

    a, b, c = permutations.first
    a * b * c
  end
end

if __FILE__ == $0
  filename = "01_input.txt"
  input = File.read(filename)
  puts Report.multiply(input)
end
