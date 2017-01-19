#Find the 10,001st prime number

def prime_divisible?(number, primes)
  primes.each { |prime|
    if number % prime == 0
      return true
    end
  }
  return false
end

discovered_primes = [3]
current_number = 5

# until prime_count >= 10001 do
while discovered_primes.count < 10000
  unless prime_divisible?(current_number, discovered_primes)
    discovered_primes.push(current_number)
    puts "Discovered: #{discovered_primes.count}"
  else
    current_number += 2
  end

  puts current_number
end

prime_count = discovered_primes.count + 1 #accounts for the 1 and 2, which has been ignored thus far
latest_prime = discovered_primes.last

puts "count: " + prime_count.to_s
puts "prime: " + latest_prime.to_s
