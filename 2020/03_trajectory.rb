class Trajectory
  def self.count_trees(tree_lines, slope_x: 3, slope_y: 1)
    tree_line_length = tree_lines.first.length

    tree_count = 0
    index_x = 0
    index_y = 0
    until index_y >= (tree_lines.size - 1)
      index_x = (index_x + slope_x) % tree_line_length
      index_y += slope_y
      tree_count += 1 if tree_lines.fetch(index_y).chars[index_x] == "#"
    end
    tree_count
  end
end

if __FILE__ == $0
  filename = "03_input.txt"
  input = File.read(filename).split("\n")
  puts "part 1: #{Trajectory.count_trees(input)}"

  part_2 = [
    Trajectory.count_trees(input, slope_x: 1, slope_y: 1),
    Trajectory.count_trees(input, slope_x: 3, slope_y: 1),
    Trajectory.count_trees(input, slope_x: 5, slope_y: 1),
    Trajectory.count_trees(input, slope_x: 7, slope_y: 1),
    Trajectory.count_trees(input, slope_x: 1, slope_y: 2)
  ].inject(:*)
  puts "part 2: #{part_2}"
end
