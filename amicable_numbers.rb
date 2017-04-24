def is_amicable(sums, x)
  unless x == 1
    a = sums[x-1]
    if a
      b = sums[a-1]
      if b == x && a != b
        puts "#{b}: #{a}"
        return true
      end
    end
  end
  return false
end

def sum_amicable_numbers_under input
  sums = [*1..(input-1)].map { |x| sum_divisors x }
  amicables = sums.select {|x| is_amicable(sums, x)}
  print amicables.uniq
  amicables.uniq.reduce(:+)
end

def sum_divisors number
  sum = 1
  divisor = 2
  higher = number
  until divisor == higher || divisor > higher
    if number % divisor == 0
      higher = number / divisor
      sum += divisor + higher
    end
    divisor += 1
  end
  sum
end

puts sum_amicable_numbers_under(10 * 1000)
