input = File.read("08_input.txt").chomp
width = 25
height = 6

layers = input.chars.map(&:to_i).each_slice(width).each_slice(height)
canvas = Array.new(height) { Array.new(width) }

layers.each do |layer|
  layer.each_with_index do |pixel_row, row_index|
    pixel_row.each_with_index do |pixel, column_index|
      value = case pixel
        when 0
          :black
        when 1
          :white
        when 2
          nil # transparent
        else
          raise ArgumentError, "unknown value #{pixel}"
      end
      canvas[row_index][column_index] ||= value
    end
  end
end

canvas.each do |row|
  pixels = row.map do |pixel|
    case pixel
      when :black
        "⬛︎"
      when :white
        "⬜︎"
      else
        "?"
    end
  end
  puts pixels.join
end
