class GravityAssist
  OPCODE_MAP = {
    1 => :add,
    2 => :multiply,
    99 => :terminate,
  }

  def initialize(intcode)
    @intcode = intcode
    @pointer = 0
  end

  def start
    loop do
      opcode = OPCODE_MAP.fetch(@intcode[@pointer])
      if opcode == :terminate
        puts "Exiting, pointer: #{@pointer}, intcode: #{@intcode.join(",")}"
        break
      end

      in_pos1 = @intcode[@pointer + 1]
      in_pos2 = @intcode[@pointer + 2]
      out_pos = @intcode[@pointer + 3]
      send(opcode, in_pos1, in_pos2, out_pos)

      @pointer += 4
    end
  end

  def add(in_pos1, in_pos2, out_pos)
    @intcode[out_pos] = @intcode[in_pos1] + @intcode[in_pos2]
  end

  def multiply(in_pos1, in_pos2, out_pos)
    @intcode[out_pos] = @intcode[in_pos1] * @intcode[in_pos2]
  end
end

input = if ENV["INTCODE"]
  ENV["INTCODE"].split(",").map(&:to_i)
else
  raw = File.read("02_input.txt").chomp.split(",").map(&:to_i)
  raw[1] = 12
  raw[2] = 2
  raw
end
GravityAssist.new(input).start
