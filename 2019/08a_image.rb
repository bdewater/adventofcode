input = File.read("08_input.txt").chomp
width = 25
height = 6

layers = input.chars.map(&:to_i).each_slice(width).each_slice(height)

fewest_zero_layer = layers.min_by do |layer|
  layer.sum do |pixel_row|
    pixel_row.count do |pixel|
      pixel == 0
    end
  end
end

flattened_layer = fewest_zero_layer.flatten
one_digits = flattened_layer.count do |pixel|
  pixel == 1
end
two_digits = flattened_layer.count do |pixel|
  pixel == 2
end
puts one_digits * two_digits
