class Integer
  def million
    self.thousand.thousand
  end

  def thousand
    self * 1000
  end
end

def collatz number
  length = 1
  unless number == 1
    if number.even?
      length = 1 + collatz(number/2)
    else
      length = 1 + collatz((number*3)+1)
    end
  end
  length
end

def print_largest_collatz_chain_under number
  i = 1
  max = 1
  max_seed = 1
  until i == number
    length = collatz(i)
    if length > max
      max = length
      max_seed = i
      puts "#{max_seed}: #{max}"
    end
    i += 1
  end
  puts "Seed: #{max_seed}"
  puts "Size: #{max}"
end

print_largest_collatz_chain_under 1.million
