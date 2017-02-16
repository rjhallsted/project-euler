#find the largest palindrome product of two 3-digit numbers

#readable
def is_palindrome?( number )
  initial = number.to_s
  reversed = number.to_s.reverse!
  initial === reversed
end

palindromes = Array.new
for factor_one in 900..999
  for factor_two in 900..999
    product = factor_one * factor_two
    if is_palindrome?(product)
      palindromes.push(product)
    end
  end
end

puts palindromes.max

#############################
#clever
class Integer
  def palindrome?
    self.to_s === self.to_s.reverse!
  end
end

products = [*900..999].combination(2).map { |combo| combo.reduce(:*) }
palindromes = products.select { |n| n.palindrome? }
puts palindromes.max
