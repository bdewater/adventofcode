class CircuitBoard
  Position = Struct.new(:x, :y) do
    def left
      self.x -= 1
    end

    def up
      self.y += 1
    end

    def right
      self.x += 1
    end

    def down
      self.y -= 1
    end
  end

  START_POS = Position.new(0, 0).freeze

  def initialize(wires)
    @circuits = Hash.new { |hash, key| hash[key] = [] }
    @wires = wires
  end

  def run_wires
    @wires.each_with_index do |wire, wire_nr|
      run_wire(wire, wire_nr)
    end
  end

  def find_intersection
    intersections = @circuits[0] & @circuits[1]
    intersections
      .map { |location| manhattan_distance(START_POS, location) }
      .sort
      .first
  end

  def run_wire(wire, wire_nr)
    location = START_POS.dup
    wire.each do |input|
      _, direction, steps = input.match(/\A([A-Z])(\d*)\z/).to_a
      steps = steps.to_i

      case direction
        when "L"
          steps.times do
            location.left
            mark_wire(location, wire_nr)
          end
        when "U"
          steps.times do
            location.up
            mark_wire(location, wire_nr)
          end
        when "R"
          steps.times do
            location.right
            mark_wire(location, wire_nr)
          end
        when "D"
          steps.times do
            location.down
            mark_wire(location, wire_nr)
          end
        else
          raise ArgumentError, "invalid direction #{direction}"
      end
    end
  end

  def mark_wire(location, wire_nr)
    @circuits[wire_nr] << location.dup
  end

  def manhattan_distance(location1, location2)
    (location1.x - location2.x).abs + (location1.y - location2.y).abs
  end
end

data = File.readlines("03_input.txt", chomp: true).map { |line| line.split(",") }
board = CircuitBoard.new(data)
board.run_wires
puts board.find_intersection
