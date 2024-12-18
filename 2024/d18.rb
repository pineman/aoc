input = File.readlines("input/18", chomp: true)

ex = ["5,4", "4,2", "4,5", "3,0", "2,1", "6,3", "2,4", "1,5", "0,6", "3,3", "2,6", "5,1", "1,2", "5,5", "2,5", "6,5", "1,4", "0,4", "6,4", "1,1", "6,1", "1,0", "0,5", "1,6", "2,0"]

def n(map, u)
  i, j = u
  m = map.size-1
  r = []
  if j < m && map[i][j+1] == ?.
    r << [i, j+1]
  end
  if j > 0 && map[i][j-1] == ?.
    r << [i, j-1]
  end
  if i < m && map[i+1][j] == ?.
    r << [i+1, j]
  end
  if i > 0 && map[i-1][j] == ?.
    r << [i-1, j]
  end
  r
end

def s(map, sc, tc)
  si, sj = sc
  ti, tj = tc
  # straight outta wikipedia
  q = []
  dist = {}
  prev = {}
  map.each.with_index { |r, i| 
    r.each.with_index { |_, j|
      dist[[i,j]] = Float::INFINITY
      prev[[i,j]] = nil
      q << [i,j]
    }
  }
  dist[[si, sj]] = 0
  while !q.empty?
    u = q.min_by { dist[_1] }
    break if u == [ti, tj]
    q.delete(u)
    (n(map, u) & q).each { |v|
      alt = dist[u] + 1
      if alt < dist[v]
        dist[v] = alt
        prev[v] = u
      end
    }
  end
  [dist, prev]
end

def part_one(input, m, n)
  map = Array.new(m) { Array.new(m, ?.) }
  input.map { _1.split(?,).map(&:to_i) }.slice(...n).each { |j, i| map[i][j] = ?# }

  si, sj = [0, 0]
  ti, tj = [m-1, m-1]
  _, prev = s(map, [si, sj], [ti, tj])

  i,j = [ti,tj]
  begin
    map[i][j] = ?O
  end while (i,j = prev[[i,j]]) # ruby do ... while, idc what Matz has to say!!!
  map.sum { |r| r.count { _1 == ?O } } - 1
end

puts part_one(ex, 7, 12)
#puts part_one(input, 71, 1024) # 260


def part_two(input, m, n)
  map = Array.new(m) { Array.new(m, ?.) }
  bytes = input.map { _1.split(?,).map(&:to_i) }
  bytes[...n].each { |j, i| map[i][j] = ?# }

  si, sj = [0, 0]
  ti, tj = [m-1, m-1]
  _, prev = s(map, [si, sj], [ti, tj])

  bytes[n..].find.with_index { |(j, i), a|
    p a
    map[i][j] = ?#
    _, prev = s(map, [si, sj], [ti, tj])
    prev[[ti,tj]] == nil
  }.join(?,)
end

#puts part_two(ex, 7, 12)
puts part_two(input, 71, 1024) # 260

