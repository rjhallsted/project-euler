def find_divisors_of number
  max = (number/2.0).ceil
  [*1..max].select{ |x| number % x == 0}
end

def is_abundant_number? number
  divisors = find_divisors_of number
  divisors.reduce(:+) > number
end

def add_to_combo_sums(number, abundants, sums)
  new_sums = abundants.map {|x| x+number}
  (sums + new_sums).uniq
end

def sum_of_all_passable_abundants
  max = 28123
  passables = []
  combo_sums = []
  abundants = []
  for number in 1..(max-1)
    if is_abundant_number? number
      abundants.push(number)
      combo_sums = add_to_combo_sums(number, abundants, combo_sums)
    end
    unless combo_sums.include? number
      passables.push(number)
      puts number
    end
  end
  passables.reduce(:+)
end

puts sum_of_all_passable_abundants
