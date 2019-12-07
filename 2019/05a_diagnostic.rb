class Diagnostic
  Opcode = Struct.new(:instruction, :parameter_count)

  OPCODE_MAP = {
    1 => Opcode.new(:add, 3),
    2 => Opcode.new(:multiply, 3),
    3 => Opcode.new(:input, 1),
    4 => Opcode.new(:output, 1),
    99 => Opcode.new(:terminate, nil),
  }

  MODE_MAP = {
    0 => :position,
    1 => :immediate,
  }

  def initialize(intcode)
    @intcode = intcode
    @pointer = 0
  end

  def start
    loop do
      raw_opcode = @intcode[@pointer].rjust(2, "0")[-2..-1]
      opcode = OPCODE_MAP.fetch(raw_opcode.to_i)
      if opcode.instruction == :terminate
        puts "Exiting, pointer: #{@pointer}, intcode: #{@intcode.join(",")}"
        break
      end

      parameters = @intcode[@pointer + 1, opcode.parameter_count].map(&:to_i)

      raw_parameter_modes = @intcode[@pointer][0..-3]
      parameter_modes = raw_parameter_modes
        .rjust(opcode.parameter_count, "0")
        .chars.map(&:to_i).reverse
        .map { |mode| MODE_MAP.fetch(mode) }

      send(opcode.instruction, *parameters.zip(parameter_modes))
    end
  end

  def position_read(value)
    @intcode[value]
  end

  def immediate_read(value)
    value
  end

  def add(in2_mode, in1_mode, out)
    out_pos, out_mode = out
    raise ArgumentError unless out_mode == :position

    in2, in1 = [in2_mode, in1_mode].map do |value, mode|
      send(:"#{mode}_read", value).to_i
    end
    @intcode[out_pos] = (in2 + in1).to_s

    @pointer += 4
  end

  def multiply(in2_mode, in1_mode, out)
    out_pos, out_mode = out
    raise ArgumentError unless out_mode == :position

    in2, in1 = [in2_mode, in1_mode].map do |value, mode|
      send(:"#{mode}_read", value).to_i
    end
    @intcode[out_pos] = (in2 * in1).to_s

    @pointer += 4
  end

  def input(out)
    out_pos, out_mode = out
    raise ArgumentError unless out_mode == :position

    puts "Enter input:"
    in1 = gets.chomp
    @intcode[out_pos] = in1.to_s

    @pointer += 2
  end

  def output(out)
    out_pos, out_mode = out

    value = send(:"#{out_mode}_read", out_pos).to_i
    puts "output: #{value}"

    @pointer += 2
  end
end

input = if ENV["INTCODE"]
  ENV["INTCODE"].split(",")
else
  raw = File.read("05_input.txt").chomp.split(",")
  raw
end
Diagnostic.new(input).start
