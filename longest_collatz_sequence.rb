class Integer
  def million
    self * 1000 * 1000
  end
end

def collatz( number, lengths )
  if lengths[number].nil?
    if number.even?
      next_number = number/2
    else
      next_number = (number * 3) + 1
    end
    unless lengths[next_number].nil?
      lengths[number] = lengths[next_number] + 1
    else
      lengths = collatz(next_number, lengths)
      lengths[number] = lengths[next_number] + 1
    end
  end
  puts "#{number}: #{lengths[number]}"
  lengths
end

def largest_collatz_chain_under number
  lengths = [0,1]
  i = 2
  until i == number
    lengths = collatz(i, lengths)
    i += 1
  end
  print lengths
  lengths.index(lengths.max)
end

puts largest_collatz_chain_under 1.million
