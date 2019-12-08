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

  def hops_to_common_parent
    my_path = collect_parents("YOU")
    santa_path = collect_parents("SAN")
    common_parent = (my_path & santa_path).first

    my_path.index(common_parent) + santa_path.index(common_parent)
  end

  def collect_parents(obj)
    nodes = []
    parent, _ = @nodes.find { |_k, v| v.include?(obj) }

    loop do
      if parent.nil?
        break
      else
        nodes << parent
        parent, _ = @nodes.find { |_k, v| v.include?(parent) }
      end
    end
    nodes
  end
end

input = File.readlines("06_input.txt", chomp: true)
orbit = Orbit.new(input)
orbit.build_tree
puts orbit.hops_to_common_parent
