# Fuel itself requires fuel just like a module - take its mass, divide by three, round down, and subtract 2.
# However, that fuel also requires fuel, and that fuel requires fuel, and so on. Any mass that would require negative
# fuel should instead be treated as if it requires zero fuel; the remaining mass, if any, is instead handled by wishing
# really hard, which has no mass and is outside the scope of this calculation.
#
# So, for each module mass, calculate its fuel and add it to the total. Then, treat the fuel amount you just calculated
# as the input mass and repeat the process, continuing until a fuel requirement is zero or negative. For example:
#
#  - A module of mass 14 requires 2 fuel. This fuel requires no further fuel (2 divided by 3 and rounded down is 0,
#    which would call for a negative fuel), so the total fuel required is still just 2.
#  - At first, a module of mass 1969 requires 654 fuel. Then, this fuel requires 216 more fuel (654 / 3 - 2).
#    216 then requires 70 more fuel, which requires 21 fuel, which requires 5 fuel, which requires no further fuel.
#    So, the total fuel required for a module of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966.
#  - The fuel required by a module of mass 100756 and its fuel is:
#    33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346.
#
# What is the sum of the fuel requirements for all of the modules on your spacecraft when also taking into account the
# mass of the added fuel? (Calculate the fuel requirements for each module separately, then add them all up at the end.)

def calculate_fuel(mass)
  (mass.to_i / 3).floor - 2
end

def calculate_fuel_for_fuel(mass)
  mass_left = mass
  fuel = 0
  loop do
    more_fuel = calculate_fuel(mass_left)
    if more_fuel.negative?
      break # wishing really hard
    else
      mass_left = more_fuel
      fuel += more_fuel
    end
  end
  fuel
end

input = ENV["MASS"] ? [ENV["MASS"].to_i] : File.readlines("01_input.txt").map(&:to_i)

total = input.sum(0) do |module_mass|
  module_fuel = calculate_fuel(module_mass)
  fuel_fuel = calculate_fuel_for_fuel(module_fuel)

  module_fuel + fuel_fuel
end

puts total