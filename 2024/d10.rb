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
  mi = map.size - 1
  mj = map[0].size - 1
  c = map[i][j]
  if c == 9
    acc << [i, j]
    return acc
  end
  n = if i > 0 && map[i-1][j] == c+1
    path(map, i-1, j, acc)
  end
  s = if i < mi && map[i+1][j] == c+1
    path(map, i+1, j, acc)
  end
  w = if j > 0 && map[i][j-1] == c+1
    path(map, i, j-1, acc)
  end
  e = if j < mj && map[i][j+1] == c+1
    path(map, i, j+1, acc)
  end
  [n, s, w, e].compact.reduce(&:merge)
end

def part_one(input)
  map = input.map { _1.chars.map(&:to_i) }
  zeros = []
  map.each.with_index { |r, i|
    r.each.with_index { |c, j|
      zeros << [i, j] if c == 0
    }
  }
  zeros.map { |i, j|
    path(map, i, j, Set.new)
  }.map { _1.size }.sum
end

puts part_one(input) # 652

def path2(map, i, j, acc)
  mi = map.size - 1
  mj = map[0].size - 1
  c = map[i][j]
  if c == 9
    return acc + 1
  end
  n = if i > 0 && map[i-1][j] == c+1
    path2(map, i-1, j, acc)
  end
  s = if i < mi && map[i+1][j] == c+1
    path2(map, i+1, j, acc)
  end
  w = if j > 0 && map[i][j-1] == c+1
    path2(map, i, j-1, acc)
  end
  e = if j < mj && map[i][j+1] == c+1
    path2(map, i, j+1, acc)
  end
  [n, s, w, e].compact.map{_1-acc}.compact.sum
end

def part_two(input)
  map = input.map { _1.chars.map(&:to_i) }
  zeros = []
  map.each.with_index { |r, i|
    r.each.with_index { |c, j|
      zeros << [i, j] if c == 0
    }
  }
  zeros.map { |i, j|
    path2(map, i, j, 0)
  }.sum
end

puts part_two(input) # 1432
