module Words
  extend self

  def singles number
    singles = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    singles[number]
  end

  def teens number
    teens = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
    teens[number-10]
  end

  def tens number
    tens = ["zero", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
    tens[number]
  end

  def build number
    string = ""
    if number > 999
      thousand_count = (number/1000).floor
      left = number % 1000
      string += build(thousand_count) + " thousand"
      unless left == 0
        string += " and " + build(left)
      end
    elsif number > 99
      hundred_count = (number/100).floor
      left = number % 100
      string += build(hundred_count) + " hundred"
      unless left == 0
        string += " and " + build(left)
      end
    elsif number > 19
      ten_count = (number/10).floor
      left = number % 10
      string += tens ten_count
      unless left == 0
        string += "-" + build(left)
      end
    elsif number > 9
      string += teens number
    else
      string += singles number
    end
    string
  end
end

def remove_uncounted phrase
  phrase.delete(" -")
end

words = [*1..1000].map {|x| Words.build x }
words.map! {|x| remove_uncounted x }
words.map! {|x| x.length }
puts words.reduce(:+)
