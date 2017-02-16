#readable
sum = 0;
for i in 1..999
  if i % 3 == 0 || i % 5 == 0
    sum += i
  end
end
puts sum

#clever
modded = [*1..999].select { |i| i % 3 == 0 || i % 5 == 0 }
puts modded.inject(0) { |sum,i| sum + i }
