class Report
  def self.multiply(input)
    report = input.split("\n").map(&:to_i)

    permutations = report.permutation(2).to_a
    permutations.select! { |a, b| a + b == 2020 }

    a, b = permutations.first
    a * b
  end
end

if __FILE__ == $0
  filename = "01_input.txt"
  input = File.read(filename)
  puts Report.multiply(input)
end
