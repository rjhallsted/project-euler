def factorize( number_to_factor )
  factors = Array.new
  i = 2
  divider = 2
  until i == number_to_factor/divider do
    other_side = number_to_factor / i
    if number_to_factor % i == 0
      factors.push(i)
      factors.push(other_side)
      divider = i
    end
    i += 1
  end
  return factors
end

def remove_non_primes( number_array )
  primes = Array.new
  number_array.each do |number|
    factors = factorize(number)
    unless factors.length > 0
      primes.push(number)
    end
  end
  return primes
end

input = 600851475143
factors = factorize(input)
prime_factors = remove_non_primes(factors)
puts prime_factors.max
