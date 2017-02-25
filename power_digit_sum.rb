#What is the sum of the digits of the number 21000?
number = (2**1000).to_s
array = number.split("").map { |x| x.to_i }
puts array.reduce(:+)
