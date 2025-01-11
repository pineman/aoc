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

exsaveme = [
  "AAAB",
  "ABAA",
  "ABAB",
  "BBAB",
  "AAAB"
]

exsaveme2 = [
  "BBBBB",
  "BAAAA",
  "BBBBB"
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

puts part_one(input) # 1375574


# +-+-+-+-+
# |A A A A|
# +-+-+-+-+     +-+
#          X    |D|
# +-+-+   +-+   +-+
# |B B|  X|C|X
# +   +   + +-+
# |B B|  X|C C|X
# +-+-+   +-+ +
#          X|C|X
# +-+-+-+   +-+
# |E E E|    X
# +-+-+-+
# 
#  XXXX
# XAAAAX
#  XXXX
# 
#  XXX
# XAAAX
#  XXAX
#   XAX
#    X
#   
#   XX
#  XAAX
#   XAX
#    X
# 
# faces = 8
# x = 10
# adj = 4
# x_comp = 12
#   XX
#  XAAX
#   XAX
#  XAAX
#   XX

ex4 = [
  "EEEEE",
  "EXXXX",
  "EEEEE",
  "EXXXX",
  "EEEEE"
]

ex5 = [
  "AAAAAA",
  "AAABBA",
  "AAABBA",
  "ABBAAA",
  "ABBAAA",
  "AAAAAA"
]

exx = [
  "AUUUU",
  "AAAAU",
  "AUAUU",
  "UUUUU"
]

exxx = [
  "TTAA",
  "TTAA",
  "TAAA",
  "TTTT"
]

def pad(map)
  mi = map.size
  mj = map[0].size
  pad = Array.new(mi + 2) { Array.new(mj + 2, nil) }
  map.each.with_index { |r, i|
    r.each.with_index { |c, j|
      pad[i+1][j+1] = map[i][j]
    }
  }
  pad
end


# AAA   
# A A
# A A
#   A
# AAA
# 
# from W to E, cols A guys who dont have a A neighbor to the W and are not adjacent going N
# 2, 0, 1
# 
# from E to W, cols A guys who dont have a A neighbor to the E and are not adjacent going N 
# 1, 0, 1
# 
# from N to S, rows A guys who dont have a A neighbor to the N and are not adjacent going W
# 1, 0, 0, 0, 1
# 
# from S to N, rows A guys who dont have a A neighbor to the S and are not adjacent going W
# 1, 0, 1, 0, 1
# 
# t = 2 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 = 10
# 
# AAA   
# A AA
# A A
#   A
# AAA
# 
# from W to E, cols A guys who dont have a A neighbor to the W and dont have a A neighbor to the N (faces N to S)
# 2, 0, 
# 
# from E to W, cols A guys who dont have a A neighbor to the E and are not adjacent going N (faces S to N)
# 
# 
# from N to S, rows A guys who dont have a A neighbor to the N and are not adjacent going W (faces W to E)
# 
# 
# from S to N, rows A guys who dont have a A neighbor to the S and are not adjacent going W (faces E to W)
# 
# 
# t = 2 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 = 10
# 
# XCXC
# XCCX
# XXCX
# 
# 1. from W to E, cols A guys who dont have a A neighbor to the W and are not adjacent going N (faces N to S)
# 1, 1
# 
# 2. from E to W, cols A guys who dont have a A neighbor to the E and are not adjacent going N (faces S to N)
# 1, 1
# 
# 3. from N to S, rows A guys who dont have a A neighbor to the N and are not adjacent going W (faces W to E)
# 1, 0
# 
# 4. from S to N, rows A guys who dont have a A neighbor to the S and are not adjacent going W (faces E to W)
# 1, 0

def m(pad, shape_set)
  shape_set.map! { |i,j| [i+1,j+1] }
  mi = pad.size - 1
  mj = pad[0].size - 1
  i,j = shape_set.first
  l = pad[i][j]
  sides = 0

  # from W to E, cols A guys who dont have a A neighbor to the W and are not adjacent going N 
  (1...mj).each { |j|
    active = false
    (1...mi).to_a.each { |i|
      next if pad[i][j] == l && !shape_set.include?([i,j])
      new_active = pad[i][j] == l && pad[i][j-1] != l
      if !active && new_active
        active = true
        sides += 1
      elsif active && !new_active
        active = false
      end
    }
  }

  # from W to E, cols A guys who dont have a A neighbor to the E and are not adjacent going N 
  (1...mj).to_a.reverse.each { |j|
    active = false
    (1...mi).to_a.each { |i|
      next if pad[i][j] == l && !shape_set.include?([i,j])
      new_active = pad[i][j] == l && pad[i][j+1] != l
      if !active && new_active
        active = true
        sides += 1
      elsif active && !new_active
        active = false
      end
    }
  }

  # from N to S, rows A guys who dont have a A neighbor to the N and are not adjacent going W
  (1...mi).each { |i|
    active = false
    (1...mj).to_a.each { |j|
      next if pad[i][j] == l && !shape_set.include?([i,j])
      new_active = pad[i][j] == l && pad[i-1][j] != l
      if !active && new_active
        active = true
        sides += 1
      elsif active && !new_active
        active = false
      end
    }
  }

  # from S to N, rows A guys who dont have a A neighbor to the S and are not adjacent going W
  (1...mi).to_a.reverse.each { |i|
    active = false
    (1...mj).to_a.each { |j|
      next if pad[i][j] == l && !shape_set.include?([i,j])
      new_active = pad[i][j] == l && pad[i+1][j] != l
      if !active && new_active
        active = true
        sides += 1
      elsif active && !new_active
        active = false
      end
    }
  }

  sides
end


def part_two(input)
  map = input.map(&:chars)
  pad = pad(map)
  v_set = Set.new
  map.flat_map.with_index { |r, i|
    r.map.with_index { |c, j|
      next if v_set.include?([i, j])
      v_set_bak = v_set.clone
      area, per = r(map, v_set, i, j, 0, 0)
      shape_set = v_set - v_set_bak
      area * m(pad, shape_set)
    }
  }.compact.sum
end

#puts part_two(ex) # 80
#puts part_two(exsaveme)
#puts part_two(exsaveme2)
#puts part_two(ex2) # 436
#puts part_two(ex4) # 236
#puts part_two(ex3) # 1206
#puts part_two(exx)
#puts part_two(exxx)
puts part_two(input) # 830566
