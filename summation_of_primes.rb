#find the sum of all primes under 2 million
#using the AKS primality test: https://en.wikipedia.org/wiki/AKS_primality_test

##Polynomial math
###explicitly polynomial subtraction

module Math
  extend self

  def coprime?(first, second)
    # puts "coprime?(#{first}, #{second})"
    self.gcd(first, second) == 1
  end

  def gcd(a,b)
    # puts "gcd(#{a},#{b})"
    unless [a,b].any? { |x| x <= 0 }
      if a == b
        return a
      else
        self.gcd([a,b].max - [a,b].min, [a,b].min)
      end
    end
  end

  def get_pascals_triangle_at_level max_level
    if max_level <= 2
      row = max_level.times.collect{|e| 1 }
    else
      row = get_pascals_triangle_at_level max_level-1
      new_row = [1]
      for level in 2..max_level-1
        new_row.push(row[level-2] + row[level-1])
      end
      new_row.push(1)
      row = new_row
    end
    row
  end
end

class Integer
  def million
    self * 1000 * 1000
  end

  def prime_divisible? primes_below
    primes_below.each { |prime|
      if self % prime == 0
        return true
      end
    }
    return false
  end

  def perfect_power?
    [*2..self].repeated_permutation(2).any? { |combo| combo.first**combo.last == self }
  end

  def max_remainder modulo_by
    # puts "max_remainder(#{number}, #{modulo_by})"
    nums = Array.new
    for x in 0..self*modulo_by
      remainder = self**x % modulo_by
      nums.push(remainder)
    end
    nums.max
  end

  def smallest_coprime_r

    logged = Math.log2(self)
    max_k = (logged**2).floor
    max_r = [3, (logged**5).ceil].max
    next_r = true

    r = 2
    while r < max_r && next_r
      next_r = false
      k = 1
      while k <= max_k && !next_r
        next_r = (self**k) % r == 1 || (self**k) % r == 0
        k +=1
      end
      r += 1
    end
    r - 1
  end

  def count_coprimes_below
    count = 0
    for x in 1..self-1
      if Math.coprime?(self, x)
        count += 1
      end
    end
    return count
  end

  def prime?
    puts "#{self}.prime?"
    unless self.perfect_power?
      puts "not perfect power"
      r = self.smallest_coprime_r
      puts "r=#{r}"
      for a in r..2
        gcd = Math.gcd(a, self)
        if gcd > 1 && gcd < self
          return false
        end
      end
      unless self > 5690034
        if self <= r
          return true
        end
      end
      #All the complex polynomial shit goes here. Working on it.
      loop_max = (Math.sqrt(r.count_coprimes_below) * Math.log2(self)).floor

      puts "-"*15

      expanded_poly_zero = "x^#{self}"
      #build pascals triangle to level of self to find coefficients of expanded poly
      coefficients = Math.get_pascals_triangle_at_level self+1
      for i in 1..self-1
        expanded_poly_zero += "+#{coefficients[i]}x^#{self-i}b^#{i}"
      end
      expanded_poly_zero += "+b^#{self}"

      poly_zero = Polynomial.new(expanded_poly_zero)
      r_poly = Polynomial.new("x^#{r}-1")
      poly_one = Polynomial.new("x^#{self}+b")

      # func_a = poly_mod( Polys.poly_rem(poly_zero, r_poly), self)
      func_b = poly_rem(poly_one, r_poly)
      # for b in 2..loop_max
      #   func_c = poly_subtract(func_a, func_b)
      #   result = func_c.evaluate({b: b})
      #   if result % self != 0
      #     return false
      #   end
      # end
      return true
    end
    return false
  end
end

class PolyTerm
  attr_reader :parts

  def initialize input
    @parts = make_parts input

  end

  def make_parts input
    pieces = input.split ""
    multiplier = 1
    parts = { coefficient: 1, variables: Array.new }
    index = 0
    until index >= pieces.count do
      piece = pieces[index]
      if piece == "-"
        multiplier = -1
        # puts "#{piece}: minus"
      elsif piece == '+'
        multiplier = 1
        # puts "#{piece}: plus"
      elsif /[a-zA-Z]/.match piece
        #variable and degree
        if pieces[index+1] == "^"
          matched = false
          index += 2
          number = ""
          until matched || index >= pieces.count
            if /[\+\-\p{Alpha}]/.match pieces[index]
              matched = true
              index -= 1
            else
              number += pieces[index]
              index += 1
            end
          end
          parts[:variables].push({name: piece, degree: number.to_i})
          # puts "#{piece}: variable => #{piece}, degree => #{number.to_i}"
        end
      elsif /\d/.match piece
        #coefficient
        number = piece
        matched = false
        index += 1
        until matched || index >= pieces.count
          if /[\+\-\p{Alpha}]/.match pieces[index]
            matched = true
            index -= 1
          else
            number += pieces[index].to_s
            index += 1
          end
        end
        parts[:coefficient] = number.to_i * multiplier
        # puts "#{piece}: coefficient"
        multiplier = 1
      end
      index += 1
    end
    parts
  end

  def readable
    text = "#{@parts[:coefficient]}"
    if defined? @parts[:variables]
      @parts[:variables].each { |variable| text += "#{variable[:name]}^#{variable[:degree]}"}
    end
    text
  end

  def print_parts
    puts readable
  end

  def multiply_by factor
    coefficient = self.parts[:coefficient] * factor.parts[:coefficient]
    variables = ""
    self.parts[:variables].each do |variable|
      if factor.parts[:variables].any? { |v| v[:name] == variable[:name] }
        test_against = factor.parts[:variables].select { |v| v[:name] == variable[:name] }
        test_against = test_against.first
        if variable[:degree] >= test_against[:degree]
          resulting = variable[:degree] + test_against[:degree]
          variables += "#{variable[:name]}^#{resulting}"
        end
      end
    end
    string = coefficient.to_s + variables
    PolyTerm.new(string)
  end

  def divide_by divisor
    coefficient = self.parts[:coefficient] / divisor.parts[:coefficient]
    variables = ""
    self.parts[:variables].each do |variable|
      if divisor.parts[:variables].any? { |v| v[:name] == variable[:name] }
        test_against = divisor.parts[:variables].select { |v| v[:name] == variable[:name] }
        test_against = test_against.first
        if variable[:degree] >= test_against[:degree]
          resulting = variable[:degree] - test_against[:degree]
          variables += "#{variable[:name]}^#{resulting}"
        end
      end
    end
    string = coefficient.to_s + variables
    PolyTerm.new(string)
  end
end

class Polynomial
  attr_reader :degree, :terms, :readable

  def initialize poly_func
    @readable = strip_whitespace poly_func
    @terms = turn_readable_into_terms
    @degree = get_function_degree
  end

  def strip_whitespace func
    func.gsub(/\s+/, "")
  end

  def turn_readable_into_terms
    terms = @readable.split(/([\+\-])(?=[^\)]*(?:\(|$))/) #split by + or -, unless inside of parentheses. Keep the delimeter.
    cleaned_terms = group_signs_to_terms terms
    # puts cleaned_terms
    cleaned_terms.map! do |term|
      PolyTerm.new(term)
    end
  end

  def group_signs_to_terms terms
    cleaned_terms = Array.new
    terms.each_with_index do |term, index|
      if term == "+" || term == "-"
        term += terms[index+1]
        terms.delete_at(index+1)
      end
      cleaned_terms.push term
    end
    cleaned_terms
  end

  def get_function_degree
    degrees = Array.new
    @terms.each do |term|
      if term.parts.key? :variables
        values = term.parts[:variables].collect { |v| v[:degree] }
        values.map! { |x| if x.nil? then return 0 else return x end }
        degrees.push values.flatten!
      end
    end
    degrees.max
  end

  def evaluate argument

  end

  def minus subtrahend

  end

  def multiply_by factor

  end
end

def poly_mod(poly_one, poly_two, number)

end

def poly_rem(dividend, divisor)
  dividend_first = dividend.terms.first
  divisor_first = divisor.terms.first

  term = dividend_first.divide_by divisor_first
  #bookmark
  dividend = dividend.minus( divisor.multiply_by term )
  if dividend.degree > divisor.degree
    remainder = poly_rem(dividend, divisor)
  end
  remainder
end

def poly_subtract(poly_one, poly_two)

end

def sum_of_primes_under number
  discovered_primes = [2]
  current_number = 3

  until current_number >= number
    if current_number.prime?
      discovered_primes.push current_number
      # puts current_number
    end
    current_number +=2
  end
  discovered_primes.reduce(:+)
end

# term = PolyTerm.new({coefficient: 1, variable: '(x + z)', degree: 3}, {variable: 'a'}, {coefficient: 3})
# term.print

# puts sum_of_primes_under 2.million
# puts 31.prime?
# puts sum_of_primes_under 10

poly_one = Polynomial.new("x^2+2x^1-7")
poly_two = Polynomial.new("1x^1-2")
remainder = poly_rem(poly_one, poly_two)
puts remainder
