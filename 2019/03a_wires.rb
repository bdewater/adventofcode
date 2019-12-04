class CircuitBoard
  Position = Struct.new(:x, :y)


  BOARD_SIZE = 15000
  START_POS = Position.new(7500, 7500).freeze

  def initialize(wires)
    @circuit = Array.new(BOARD_SIZE) do
      Array.new(BOARD_SIZE)
    end
    @wires = wires
    @crossings = []
  end

  def find_intersections
    @wires.each_with_index do |wire, wire_nr|
      run_wire(wire, wire_nr)
    end

    @crossings
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
            location.x -= 1
            mark_wire(location, wire_nr)
          end
        when "U"
          steps.times do
            location.y += 1
            mark_wire(location, wire_nr)
          end
        when "R"
          steps.times do
            location.x += 1
            mark_wire(location, wire_nr)
          end
        when "D"
          steps.times do
            location.y -= 1
            mark_wire(location, wire_nr)
          end
        else
          raise ArgumentError, "invalid direction #{direction}"
      end
    end
  end

  def mark_wire(location, wire_nr)
    peek = @circuit[location.x][location.y]
    if peek && !peek.empty? && !peek.include?(wire_nr)
      @crossings << location.dup
    end

    unless peek&.include?(wire_nr)
      @circuit[location.x][location.y] ||= []
      @circuit[location.x][location.y] << wire_nr
    end
  end

  def manhattan_distance(location1, location2)
    (location1.x - location2.x).abs + (location1.y - location2.y).abs
  end
end

data = File.readlines("03_input.txt", chomp: true).map { |line| line.split(",") }
puts CircuitBoard.new(data).find_intersections
