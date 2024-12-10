input = File.readlines("input/10", chomp: true)

ex = [
  "89010123",
  "78121874",
  "87430965",
  "96549874",
  "45678903",
  "32019012",
  "01329801",
  "10456732"
]

ex2 = [
  "9990999",
  "9991999",
  "9992999",
  "6543456",
  "7999997",
  "8799978",
  "9999999"
]

# TODO: set should be for visited nodes?
def path(map, i, j, acc)
  #puts "path i = #{i}, j = #{j}, acc = #{acc}, map[i][j] = #{map[i][j]}"
  mi = map.size - 1
  mj = map[0].size - 1
  c = map[i][j]
  if c == 9
    #puts "found end"
    #puts "path returning i = #{i}, j = #{j}, acc = #{acc}, map[i][j] = #{map[i][j]}"
    acc << [i, j]
    return acc
  end
  #puts "path i = #{i}, j = #{j}, acc = #{acc}, map[i][j] = #{map[i][j]}, trying n"
  n = if i > 0 && map[i-1][j] == c+1
    path(map, i-1, j, acc)
  end
  #puts "path i = #{i}, j = #{j}, acc = #{acc}, map[i][j] = #{map[i][j]}, trying s"
  s = if i < mi && map[i+1][j] == c+1
    path(map, i+1, j, acc)
  end
  #puts "path i = #{i}, j = #{j}, acc = #{acc}, map[i][j] = #{map[i][j]}, trying w"
  w = if j > 0 && map[i][j-1] == c+1
    path(map, i, j-1, acc)
  end
  #puts "path i = #{i}, j = #{j}, acc = #{acc}, map[i][j] = #{map[i][j]}, trying e"
  e = if j < mj && map[i][j+1] == c+1
    path(map, i, j+1, acc)
  end
  #pp [n, s, w, e]
  #puts "path returning #{[n, s, w, e]} = #{[n, s, w, e].compact.reduce(&:merge)}, i = #{i}, j = #{j}, acc = #{acc}, map[i][j] = #{map[i][j]}"
  [n, s, w, e].compact.reduce(&:merge)
end

def part_one(input)
  map = input.map { _1.chars.map(&:to_i) }
  #pp map
  zeros = []
  map.each.with_index { |r, i|
    r.each.with_index { |c, j|
      zeros << [i, j] if c == 0
    }
  }
  zeros.map { |i, j|
    #puts '-'*40
    #pp [i,j]
    path(map, i, j, Set.new)
  }.map { _1.size }.sum
end

#puts part_one(ex2)
#puts part_one(ex)
puts part_one(input) # 652
