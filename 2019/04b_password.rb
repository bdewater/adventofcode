require 'set'

RANGE = 146810..612564

def double_digit?(number_array)
  occurences = number_array.each_with_object(Hash.new(0)) do |number, hash|
    hash[number] += 1
  end
  occurences.detect { |_number, count| count == 2 }
end

def increasing_digits?(number_array)
  number_array == number_array.sort
end

valid_passwords = RANGE.select do |number|
  number_array = number.to_s.chars
  double_digit?(number_array) &&
    increasing_digits?(number_array)
end

puts valid_passwords.size
