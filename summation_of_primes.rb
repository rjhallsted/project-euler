#find the sum of all primes under 2 million
#using the AKS primality test: https://en.wikipedia.org/wiki/AKS_primality_test

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

      poly_zero = Polynomial.new("(x+b)^#{self}")
      r_poly = Polynomial.new("x^#{r}-1")
      poly_one = Polynomial.new("x^#{self}+b")

      # func_a = Polys.poly_mod( Polys.poly_rem(poly_zero, r_poly), self)
      # func_b = Polys.poly_rem(poly_one, r_poly)
      # for b in 2..loop_max
      #   func_c = Polys.subtract(func_a, func_b)
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
  def initialize input
    @parts = make_parts input
    puts @parts
  end

  def make_parts input
    pieces = input.split ""
    multiplier = 1
    parts = { coefficient: 1, variable: nil, degree: 1 }
    index = 0
    until index >= pieces.count do
      piece = pieces[index]
      if piece == "-"
        multiplier = -1
      elsif piece == "("
        inner = piece
        until pieces[index] == ")" do
          index += 1
          inner += pieces[index]
        end
        parts[:variable] = inner
        if pieces[index+1] == "^"
          matched = false
          index += 2
          number = ""
          until matched || index >= pieces.count
            if /[\+\-\p{Alpha}]/.match pieces[index]
              matched = true
            else
              number += pieces[index]
              index += 1
            end
          end
          parts[:degree] = number.to_i
        end
      elsif /[a-zA-Z]/.match piece
        #variable
        parts[:variable] = piece
        if pieces[index+1] == "^"
          matched = false
          index += 2
          number = ""
          until matched || index >= pieces.count
            if /[\+\-\p{Alpha}]/.match pieces[index]
              matched = true
            else
              number += pieces[index]
              index += 1
            end
          end
          parts[:degree] = number.to_i
        end
      elsif /\d/.match piece
        #coefficient
        number = piece
        matched = false
        index += 1
        until matched || index >= pieces.count
          if /[\+\-\p{Alpha}]/.match pieces[index]
            matched = true
          else
            number += pieces[index]
            index += 1
          end
        end
        parts[:coefficient] = number.to_i * multiplier
        multiplier = 1
      end
      index += 1
    end
    parts
  end

  def readable
    text = ""
    @parts.each { |part|
      if defined? part[:variable]
        text += "#{part[:coefficient]}#{part[:variable]}^#{part[:degree]},"
      else
        text += "#{coefficient} "
      end
    }
    return text[0..-2]
  end

  def print
    puts readable
  end
end

class Polynomial
  def initialize poly_func
    @readable = strip_whitespace poly_func
    @terms = turn_readable_into_terms
  end

  def strip_whitespace func
    func.gsub(/\s+/, "")
  end

  def turn_readable_into_terms
    puts @readable
    terms = @readable.split(/([\+\-])(?=[^\)]*(?:\(|$))/) #split by + or -, unless inside of parentheses. Keep the delimeter.
    cleaned_terms = group_signs_to_terms terms
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

  def expand

  end

end

def sum_of_primes_under number
  discovered_primes = [1,2]
  current_number = 3

  until current_number >= number
    if current_number.prime?
      discovered_primes.push current_number
      # puts current_number
    end
    current_number +=2
  end

  return discovered_primes.reduce(:+)
end

# term = PolyTerm.new({coefficient: 1, variable: '(x + z)', degree: 3}, {variable: 'a'}, {coefficient: 3})
# term.print

# puts sum_of_primes_under 2.million
puts 31.prime?
# puts sum_of_primes_under 10
