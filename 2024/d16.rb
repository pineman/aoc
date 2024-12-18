input = File.readlines("input/16", chomp: true)

ex = [
  "###############",
  "#.......#....E#",
  "#.#.###.#.###.#",
  "#.....#.#...#.#",
  "#.###.#####.#.#",
  "#.#.#.......#.#",
  "#.#.#####.###.#",
  "#...........#.#",
  "###.#.#####.#.#",
  "#...#.....#.#.#",
  "#.#.#.###.#.#.#",
  "#.....#...#.#.#",
  "#.###.#.#.#.#.#",
  "#S..#.....#...#",
  "###############"
]

def n(map, u, facing)
  i, j = u
  m = map.size-1
  r = []
  # east
  if facing != :west && j < m && map[i][j+1] != ?#
    score = facing == :east ? 1 : 1001
    r << [[i, j+1], score, :east]
  end
  # west
  if facing != :east && j > 0 && map[i][j-1] != ?#
    score = facing == :west ? 1 : 1001
    r << [[i, j-1], score, :west]
  end
  # south
  if facing != :north && i < m && map[i+1][j] != ?#
    score = facing == :south ? 1 : 1001
    r << [[i+1, j], score, :south]
  end
  # north
  if facing != :south && i > 0 && map[i-1][j] != ?#
    score = facing == :north ? 1 : 1001
    r << [[i-1, j], score, :north]
  end
  r
end

def s(map, sc, tc)
  q = Set.new
  face = {}
  dist = {}
  prev = {}
  map.each.with_index { |r, i| 
    r.each.with_index { |_, j|
      dist[[i,j]] = Float::INFINITY
      prev[[i,j]] = nil
      q << [i,j]
    }
  }
  dist[sc] = 0
  face[sc] = :east
  while !q.empty?
    u = q.min_by { dist[_1] }
    facing = face[u]
    break if u == tc
    q.delete(u)
    n(map, u, facing).each { |v, score, new_facing|
      next if !q.include?(v)
      face[v] = new_facing
      alt = dist[u] + score
      if alt < dist[v]
        dist[v] = alt
        prev[v] = u
      end
    }
  end
  [dist, prev]
end

def part_one(input)
  map = input.map(&:chars)
  sc = nil
  map.each.with_index { |r, i| r.each.with_index { |c, j| sc = [i, j] if c == ?S } }
  tc = nil
  map.each.with_index { |r, i| r.each.with_index { |c, j| tc = [i, j] if c == ?E } }
  dist, prev = s(map, sc, tc)

  #i,j = [ti,tj]
  #begin
  #  p dist[[i,j]]
  #  map[i][j] = ?O
  #end while (i,j = prev[[i,j]]) # ruby do ... while, idc what Matz has to say!!!
  #puts map.map(&:join).join("\n")

  dist[tc]
end

#puts part_one(ex)
puts part_one(input) # 73432
