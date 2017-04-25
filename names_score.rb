def grab_names filename
  names = []
  File.open(filename, 'r') do |f|
    names = f.read.split(',')
    names.map! { |name| name.tr("\"\n","") }
    puts names
  end
  names
end

def score_names names
  letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
  letters.map!{ |x| x.upcase }
  scores = []
  names.each_with_index do |name, rank|
    letter_score = name.split('').map{ |x| letters.index(x) + 1 }.reduce(:+)
    scores.push(letter_score * (rank+1))
  end
  scores
end

def sum_names_scores_of_file filename
  names = grab_names filename
  names.sort!
  scores = score_names names
  scores.reduce(:+)
end

filename = "names.txt"
puts sum_names_scores_of_file filename
