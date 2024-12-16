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

#puts part_one(ex)
#puts part_one(ex2)
#puts part_one(ex3)
#puts part_one(input)

def m(map, shape_set)
  mi = map.size - 1
  mj = map[0].size - 1
  pp shape_set
  i,j=shape_set.to_a[0]
  p map[i][j]
  v_count = 0
  shape_set.to_a.each { |i, j|
    v = []
    v << shape_set.include?([i-1, j]) 
    v << shape_set.include?([i+1, j]) 
    v << shape_set.include?([i, j-1])
    v << shape_set.include?([i, j+1])
    v_count += 4 if v.count{_1} == 0
    v_count += 2 if v.count{_1} == 1
    if v.count{_1} == 2
      v_count += 2 if !(shape_set.include?([i-1, j]) && shape_set.include?([i+1, j]) || shape_set.include?([i, j-1]) && shape_set.include?([i, j+1]))
    end
  }
  p v_count
  v_count
end

def part_two(input)
  map = input.map(&:chars)
  v_set = Set.new
  map.flat_map.with_index { |r, i|
    r.map.with_index { |c, j|
      next if v_set.include?([i, j])
      v_set_bak = v_set.clone
      area, per = r(map.map(&:clone), v_set, i, j, 0, 0)
      shape_set = v_set - v_set_bak
      area * m(map, shape_set)
    }
  }.compact.sum
end

puts part_two(ex)
