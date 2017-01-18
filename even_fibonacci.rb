def increment_fibonacci( fibonnaci_array )
  temp_last_number = fibonnaci_array.first
  fibonnaci_array[0] = fibonnaci_array.first + fibonnaci_array.last
  fibonnaci_array[-1] = temp_last_number
  return fibonnaci_array
end

four_million = 1000 * 4000
fibonnaci_array = [1,0]

even_fibonnaci_sum = 0
while fibonnaci_array.first < four_million do
  if fibonnaci_array.first.even?
    even_fibonnaci_sum += fibonnaci_array.first
  end
  fibonnaci_array = increment_fibonacci( fibonnaci_array )
end
print even_fibonnaci_sum.to_s + "\n"
