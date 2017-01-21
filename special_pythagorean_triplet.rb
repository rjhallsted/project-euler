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

def test_for_special_triplet(combos)
  combos.each { |combo|
    c = calculate_c(combo[0], combo[1])
    if is_integer?(c) && meets_problem_requirements?(combo[0], combo[1], c)
      return {a: combo[0], b: combo[1], c: c.to_i}
    end
  }
  return false
end

def find_special_triplet
  range = 1001.times.collect { |i| i }
  range.shift
  combos = range.combination(2).to_a
  test_for_special_triplet(combos)
end

triplet = find_special_triplet
unless triplet == false
  product = triplet[:a] * triplet[:b] * triplet[:c]
  puts "#{triplet[:a]} + #{triplet[:b]} + #{triplet[:c]} = #{product}"
else
  puts "Not found"
end
