def make_triangle string
  rows = string.split("\n")
  rows.map {|x| x.split(" ") }.map! { |x| x.map{ |y| y.to_i } }
end

def brute_force_triangle_route(triangle, row = 0, position = 0)
  sum = triangle[row][position]
  unless row == triangle.size - 1
    sum_left = brute_force_triangle_route(triangle, row + 1, position)
    sum_right = brute_force_triangle_route(triangle, row + 1, position + 1)
    sum += [sum_left, sum_right].max
  end
  sum
end

def clever_triangle_route(triangle, row = 0, position = 0)
  sum = triangle[row][position]
  unless row == triangle.size - 1
    left = triangle[row+1][position]
    right = triangle[row+1][position+1]
    if left > right
      sum += clever_triangle_route(triangle, row + 1, position)
    else
      sum += clever_triangle_route(triangle, row + 1, position)
    end
  end
  sum
end

triangle_string = "75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"

triangle = make_triangle triangle_string

puts brute_force_triangle_route triangle
