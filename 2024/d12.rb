input = File.readlines("input/12", chomp: true)

ex = [
  "AAAA",
  "BBCD",
  "BBCC",
  "EEEC"
]

ex2 = [
  "OOOOO",
  "OXOXO",
  "OOOOO",
  "OXOXO",
  "OOOOO"
]

ex3 = [
  "RRRRIICCFF",
  "RRRRIICCCF",
  "VVRRRCCFFF",
  "VVRCCCJFFF",
  "VVVVCJJCFE",
  "VVIVCCJJEE",
  "VVIIICJJEE",
  "MIIIIIJJEE",
  "MIIISIJEEE",
  "MMMISSJEEE"
]

def r(map, v_set, i, j, area, per)
  return [area, per] if v_set.include?([i, j])
  v_set << [i,j]
  area += 1
  mi = map.size - 1
  mj = map[0].size - 1
  l = map[i][j]
  v = []
  v << (i > 0  && map[i-1][j] == l ? [i-1, j] : nil)
  v << (i < mi && map[i+1][j] == l ? [i+1, j] : nil)
  v << (j > 0  && map[i][j-1] == l ? [i, j-1] : nil)
  v << (j < mj && map[i][j+1] == l ? [i, j+1] : nil)
  cont, no = v.partition { _1 }
  per += no.size
  if cont.any?
    cont.each { |i, j|
      area, per = r(map, v_set, i, j, area, per)
    }
  end
  [area, per]
end

def part_one(input)
  map = input.map(&:chars)
  v_set = Set.new
  map.flat_map.with_index { |r, i|
    r.map.with_index { |c, j|
      next if v_set.include?([i, j])
      area, per = r(map, v_set, i, j, 0, 0)
      area * per
    }
  }.compact.sum
end

puts part_one(ex)
puts part_one(ex2)
puts part_one(ex3)
puts part_one(input)
