#find the difference between the sum of the squares of 1-100 and the square of the sum of 1-100

sum_of_squares = 0
sum = 0

for number in 1..100
  sum_of_squares += number ** 2
  sum += number
end

square_of_sums = sum ** 2

difference = square_of_sums - sum_of_squares
puts difference
