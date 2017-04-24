def factorial_digit_sum number
  factorial = [*1..100].reduce(:*).to_s.split('').map{|x| x.to_i}.reduce(:+)
end

puts factorial_digit_sum 100
