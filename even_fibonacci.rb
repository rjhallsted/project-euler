class Integer
  def million
    self * 1000 * 1000
  end
end

fib_array = [0,1]
while fib_array.last < 4.million
  fib_array.push( fib_array[-2] + fib_array[-1] )
end
evens = fib_array.select { |i| i.even? }
puts evens.inject(0) { |sum, i| sum + i }
