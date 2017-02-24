#What is the value of the first triangle number to have over five hundred divisors?

class Integer
  def triangle
    (1..self).reduce(:+)
  end

  def factor_count
    factor_count, i, divider = 2, 2, 2
    until i >= self / divider
      if self % i == 0
        if self / i == i
          factor_count += 1
        else
          factor_count += 2
        end
        divider = i
      end
      i += 1
    end
    factor_count
  end
end

current, count = 1, 1
until count > 500
  current += 1
  count = current.triangle.factor_count
end

puts current.triangle
