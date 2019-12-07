class Orbit
  def initialize(map)
    @map = map
  end

  def build_tree
    @nodes = Hash.new { |hash, key| hash[key] = [] }
    @map.each do |line|
      parent, child = line.split(")")
      @nodes[parent] << child
    end
  end

  def count_orbits
    @hops = {}
    walk_nodes("COM", 1)
    @hops.values.sum
  end

  def walk_nodes(obj, count)
    @nodes[obj].each do |child|
      @hops[child] ||= count
      walk_nodes(child, count + 1)
    end
  end
end


input = File.readlines("06_input.txt", chomp: true)
orbit = Orbit.new(input)
orbit.build_tree
puts orbit.count_orbits



