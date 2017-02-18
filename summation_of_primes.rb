#find the sum of all primes under 2 million
#using the AKS primality test: https://en.wikipedia.org/wiki/AKS_primality_test

##Trial division

class Integer
  def million
    self * 1000 * 1000
  end

  def prime_divisible? primes_below
    primes_below.each { |prime|
      if self % prime == 0
        return true
      end
    }
    return false
  end

  def perfect_power?
    [*2..self].repeated_permutation(2).any? { |combo| combo.first**combo.last == self }
  end

  def prime?

  end
end

def sum_of_primes_under number
  discovered_primes = [2]
  current_number = 3

  until current_number >= number
    if current_number.prime?
      discovered_primes.push current_number
      # puts current_number
    end
    current_number +=2
  end
  discovered_primes.reduce(:+)
end

# puts sum_of_primes_under 2.million
