#find the sum of all primes under 2 million
#using the AKS primality test: https://en.wikipedia.org/wiki/AKS_primality_test

##Trial division

class Integer
  def million
    self * 1000 * 1000
  end
end

def sum_of_primes_under number
  discovered_primes = [2]
  current_number = 3

  until current_number >= number
    if is_prime(current_number, discovered_primes)
      discovered_primes.push current_number
      # puts current_number
    end
    current_number +=2
  end
  discovered_primes.reduce(:+)
end

def is_prime(number, discovered_primes)
  index = 0
  until discovered_primes[index] > Math.sqrt(number)
    if number % discovered_primes[index] == 0
      return false
    end
    index += 1
  end
  true
end

puts sum_of_primes_under 2.million
