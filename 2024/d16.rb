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

require 'algorithms'
include Containers

def s(map, sc, tc)
  q = PriorityQueue.new
  face = {}
  dist = Hash.new(Float::INFINITY)
  prev = Hash.new { |h, k| h[k] = [] }

  q.push(sc, 0)
  face[sc] = :east
  dist[sc] = 0

  while !q.empty?
    u = q.pop
    n(map, u, face[u]).each { |v, new_dist, facing|
      face[v] = facing
      new_dist = dist[u] + new_dist
      if new_dist <= dist[v]
        dist[v] = new_dist
        prev[v] << u
        q.push(v, -new_dist)
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

  #i,j = tc
  #begin
  #  p dist[[i,j]]
  #  map[i][j] = ?O
  #end while (i,j = prev[[i,j]]) # ruby do ... while, idc what Matz has to say!!!
  #puts map.map(&:join).join("\n")

  dist[tc]
end

#puts part_one(ex)
puts part_one(input) # 73432

def f(v, prev, c)
  v << c
  n = prev[c]
  return if !n
  n.each { f(v, prev, _1) }
end

def part_two(input)
  map = input.map(&:chars)
  sc = nil
  map.each.with_index { |r, i| r.each.with_index { |c, j| sc = [i, j] if c == ?S } }
  tc = nil
  map.each.with_index { |r, i| r.each.with_index { |c, j| tc = [i, j] if c == ?E } }
  dist, prev = s(map, sc, tc)

  pp prev
  v = Set.new
  f(v, prev, tc)
  v.each { |i,j| map[i][j] = ?O }
  puts map.map(&:join).join("\n")
end

puts part_two(ex)
