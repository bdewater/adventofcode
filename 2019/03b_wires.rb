class CircuitBoard
  Position = Struct.new(:x, :y, :steps_taken) do
    def left
      self.x -= 1
      self.steps_taken += 1
    end

    def up
      self.y += 1
      self.steps_taken += 1
    end

    def right
      self.x += 1
      self.steps_taken += 1
    end

    def down
      self.y -= 1
      self.steps_taken += 1
    end

    def ==(other)
      other.class == self.class &&
        self.x == other.x &&
        self.y == other.y
    end

    def eql?(other)
      self == other
    end

    def hash
      [x, y].hash
    end
  end

  START_POS = Position.new(0, 0, 0).freeze

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
    interection_steps = intersections.map do |wire0_intersection|
      wire1_intersection = @circuits[1].find do |loc|
        loc == wire0_intersection
      end
      wire0_intersection.steps_taken + wire1_intersection.steps_taken
    end
    interection_steps.sort.first
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
end

data = File.readlines("03_input.txt", chomp: true).map { |line| line.split(",") }
board = CircuitBoard.new(data)
board.run_wires
puts board.find_intersection
