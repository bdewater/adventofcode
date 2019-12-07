require 'set'

RANGE = 146810..612564

def double_digit?(number_array)
  number_array.size != number_array.to_set.size
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
