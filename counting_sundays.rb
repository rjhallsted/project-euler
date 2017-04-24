count = 0
for year in 1901..2000
  for month in 1..12
    day = Time.mktime(year, month, 1)
    if day.sunday?
      count += 1
    end
  end
end

puts count
