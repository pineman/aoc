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

def m(pad, shape_set)
  mi = pad.size - 1
  mj = pad[0].size - 1
  b = Set.new # border set
  shape_set.map! { |i,j| [i+1,j+1] }
  i, j = shape_set.to_a[0]
  l = pad[i][j]
  shape_set.each { |i, j|
    b << [i-1, j] if pad[i-1][j] != l
    b << [i+1, j] if pad[i+1][j] != l
    b << [i, j-1] if pad[i][j-1] != l
    b << [i, j+1] if pad[i][j+1] != l
  }


  a = pad.map(&:clone)
  pad.each.with_index { |r, i|
    r.each.with_index { |c, j|
      a[i][j] = ?.
    }
  }
  shape_set.each { |i, j| a[i][j] = l }
  b.each { |i, j| a[i][j] = ?x }
  puts a.map { _1.join }.join("\n")

  adj = Set.new
  b.each { |i,j|
    next if adj.include?([i,j])
    p [i,j]
    bb = b.to_a

    a = [[i,j]]
    ii, jj = [i,j]
    #if (i > 0 && shape_set.include?([i-1,j]) && pad[i-1][j]==l) || (i < mi && shape_set.include?([i+1,j]) && pad[i+1][j]==l)
      while n = bb.find { _1 == [ii,jj-1] }
        a << n unless shape_set.include?([ii-1,jj-1]) && shape_set.include?([ii+1,jj-1])
        jj -= 1
      end
      ii, jj = [i,j]
      while n = bb.find { _1 == [ii,jj+1] }
        a << n unless shape_set.include?([ii-1,jj+1]) && shape_set.include?([ii+1,jj+1])
        jj += 1
      end
    #else
      while n = bb.find { _1 == [ii-1,jj] }
        a << n unless shape_set.include?([ii-1,jj-1]) && shape_set.include?([ii-1,jj+1])
        ii -= 1
      end
      ii, jj = [i,j]
      while n = bb.find { _1 == [ii+1,jj] }
        a << n unless shape_set.include?([ii+1,jj-1]) && shape_set.include?([ii+1,jj+1])
        ii += 1
      #end
    end

    pp a

    choose = a.map { |i,j| 
      z = 0
      if i > 0 && shape_set.include?([i-1,j]) && pad[i-1][j]==l
        z+=1
      end
      if i < mi && shape_set.include?([i+1,j]) && pad[i+1][j]==l
        z+=1
      end
      if j > 0 && shape_set.include?([i,j-1]) && pad[i][j-1]==l
        z+=1
      end
      if j < mj && shape_set.include?([i,j+1]) && pad[i][j+1]==l
        z+=1
      end
      [[i,j],z]
    }
    p 'choose'
    pp choose
    pp a
    a -= [choose.max_by { _2 }[0]]
    pp a
    adj.merge(a)

    pp adj
  }

  b -= adj

  a = pad.map(&:clone)
  pad.each.with_index { |r, i|
    r.each.with_index { |c, j|
      a[i][j] = ?.
    }
  }
  shape_set.each { |i, j| a[i][j] = l }
  b.each { |i, j| a[i][j] = ?x }
  puts a.map { _1.join }.join("\n")

  x_comp = b.map { |i,j| 
    a = 0
    up = i > 0 && shape_set.include?([i-1,j]) && pad[i-1][j]==l
    down = i < mi && shape_set.include?([i+1,j]) && pad[i+1][j]==l
    left = j > 0 && shape_set.include?([i,j-1]) && pad[i][j-1]==l
    right = j < mj && shape_set.include?([i,j+1]) && pad[i][j+1]==l
    if up && down && !left && !right
      a = 1
    elsif !up && !down && left && right
      a = 1
    else
      if i > 0 && shape_set.include?([i-1,j]) && pad[i-1][j]==l
        a+=1
      end
      if i < mi && shape_set.include?([i+1,j]) && pad[i+1][j]==l
        a+=1
      end
      if j > 0 && shape_set.include?([i,j-1]) && pad[i][j-1]==l
        a+=1
      end
      if j < mj && shape_set.include?([i,j+1]) && pad[i][j+1]==l
        a+=1
      end
    end
    [[i,j], a]
  }

  a = pad.map(&:clone)
  pad.each.with_index { |r, i|
    r.each.with_index { |c, j|
      a[i][j] = ?.
    }
  }
  shape_set.each { |i, j| a[i][j] = l }
  b -= adj
  b.each { |i, j| 
    z = 0
    up = i > 0 && shape_set.include?([i-1,j]) && pad[i-1][j]==l
    down = i < mi && shape_set.include?([i+1,j]) && pad[i+1][j]==l
    left = j > 0 && shape_set.include?([i,j-1]) && pad[i][j-1]==l
    right = j < mj && shape_set.include?([i,j+1]) && pad[i][j+1]==l
    if up && down && !left && !right
      z = 1
    elsif !up && !down && left && right
      z = 1
    else
      if i > 0 && shape_set.include?([i-1,j]) && pad[i-1][j]==l
        z+=1
      end
      if i < mi && shape_set.include?([i+1,j]) && pad[i+1][j]==l
        z+=1
      end
      if j > 0 && shape_set.include?([i,j-1]) && pad[i][j-1]==l
        z+=1
      end
      if j < mj && shape_set.include?([i,j+1]) && pad[i][j+1]==l
        z+=1
      end
    end
    a[i][j] = z.to_s
  }
  puts a.map { _1.join }.join("\n")

  pp x_comp
  pp x_comp.sum { _1[1] }
  puts
  x_comp.sum { _1[1] }
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
#puts part_two(ex2) # 436
#puts part_two(ex4) # 236
#puts part_two(ex3) # 1206
#puts part_two(exx)
#puts part_two(exxx)
puts part_two(input)
