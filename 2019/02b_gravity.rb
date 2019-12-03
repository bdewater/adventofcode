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
        break @intcode[0]
      end

      noun = @intcode[@pointer + 1]
      verb = @intcode[@pointer + 2]
      out_pos = @intcode[@pointer + 3]
      send(opcode, noun, verb, out_pos)

      @pointer += 4
    end
  end

  def add(noun, verb, out_pos)
    @intcode[out_pos] = @intcode[noun] + @intcode[verb]
  end

  def multiply(noun, verb, out_pos)
    @intcode[out_pos] = @intcode[noun] * @intcode[verb]
  end
end

raw = File.read("02_input.txt").chomp.split(",").map(&:to_i)

(0..99).each do |noun|
  (0..99).each do |verb|
    input = raw.dup
    input[1] = noun
    input[2] = verb
    program = GravityAssist.new(input)
    output = program.start

    if output == 19690720
      puts 100 * noun + verb
      exit
    end
  end
end



