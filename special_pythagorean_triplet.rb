#There is one pythagorean triplet(a^2 + b^2 = c^2), for which a + b + c = 1000. Find the product, abc.

def calculate_c(a, b)
  c_squared = a**2 + b**2
  Math.sqrt(c_squared)
end

def is_integer?( number )
  number.to_i == number
end

def meets_problem_requirements?(a,b,c)
  total = a + b + c
  total == 1000
end

def makes_special_triplet?(a, b)
  c = calculate_c(a, b)
  is_integer?(c) && meets_problem_requirements?(a, b, c)
end

def find_special_triplet
  combo = [*1..1000].combination(2).detect { |a, b| makes_special_triplet?(a, b) }
  unless combo == false
    return {a: combo[0], b: combo[1], c: calculate_c(combo[0],combo[1]).to_i }
  end
  return false
end

triplet = find_special_triplet
unless triplet == false
  product = triplet[:a] * triplet[:b] * triplet[:c]
  puts "#{triplet[:a]} + #{triplet[:b]} + #{triplet[:c]} = #{product}"
else
  puts "Not found"
end
