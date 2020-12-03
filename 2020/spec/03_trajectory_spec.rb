require_relative "../03_trajectory"

RSpec.describe Trajectory do
  INPUT = <<~EOS.split("\n")
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
  EOS

  describe ".count_trees" do
    it do
      expect(described_class.count_trees(INPUT)).to eq(7)
    end
  end

  describe ".count_trees part 2" do
    it do
      total = [
        Trajectory.count_trees(INPUT, slope_x: 1, slope_y: 1),
        Trajectory.count_trees(INPUT, slope_x: 3, slope_y: 1),
        Trajectory.count_trees(INPUT, slope_x: 5, slope_y: 1),
        Trajectory.count_trees(INPUT, slope_x: 7, slope_y: 1),
        Trajectory.count_trees(INPUT, slope_x: 1, slope_y: 2)
      ].inject(:*)

      expect(total).to eq(336)
    end
  end
end
