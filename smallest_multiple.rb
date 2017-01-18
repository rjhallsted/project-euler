# what is the smallest number evenly divisible by all numbers 1-20

def is_divisible_by_digits_20_down?(test_number)
  digit = 11;
  while digit < 21
    if test_number % digit == 0
      digit += 1
    else
      return false
    end
  end
  return true
end

found_divisible = false
multiple_number = 2500

until found_divisible do
  multiple_number += 20
  found_divisible = is_divisible_by_digits_20_down?(multiple_number)
end

puts multiple_number
