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

ex2 = [
  "#################",
  "#...#...#...#..E#",
  "#.#.#.#.#.#.#.#.#",
  "#.#.#.#...#...#.#",
  "#.#.#.#.###.#.#.#",
  "#...#.#.#.....#.#",
  "#.#.#.#.#.#####.#",
  "#.#...#.#.#.....#",
  "#.#.#####.#.###.#",
  "#.#.#.......#...#",
  "#.#.###.#####.###",
  "#.#.#...#.....#.#",
  "#.#.#.#####.###.#",
  "#.#.#.........#.#",
  "#.#.#.#########.#",
  "#S#.............#",
  "#################",
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
    return [dist, prev] if u == tc
    n(map, u, face[u]).each { |v, new_dist, facing|
      face[v] = facing
      new_dist = dist[u] + new_dist
      if new_dist < dist[v]
        dist[v] = new_dist
        prev[v] << u
        q.push(v, -new_dist)
      end
    }
  end
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


def s(map, sc, tc)
  q = PriorityQueue.new
  dist = Hash.new(Float::INFINITY)
  prev = Hash.new { |h, k| h[k] = Set.new }

  q.push([sc, :east], 0)
  dist[[sc, :east]] = 0

  while !q.empty?
    u, f = q.pop
    return [dist, prev] if u == tc
    neigh = n(map, u, f)
    #debugger if [u,f] == [[7, 5], :north]
    neigh.each { |v, new_dist, facing|
      new_dist = dist[[u,f]] + new_dist
      if new_dist <= dist[[v, facing]]
        dist[[v, facing]] = new_dist
        prev[[v, facing]] << [u, f]
        q.push([v, facing], -new_dist)
      end
    }
  end

  [dist, prev]
end

def u(map, prev, dist, tc, sc)
  i,j=tc[0]
  map[i][j] = ?O
  return if tc == sc
  prev[tc].each { |m|
    u(map, prev, dist, m, sc)
  }
end

def part_two(input)
  map = input.map(&:chars)
  sc = nil
  map.each.with_index { |r, i| r.each.with_index { |c, j| sc = [i, j] if c == ?S } }
  tc = nil
  map.each.with_index { |r, i| r.each.with_index { |c, j| tc = [i, j] if c == ?E } }

  dist, prev = s(map, sc, tc)

  dists = []
  [tc].product([:north, :east, :south, :west]).each { 
    dists << dist[_1]
  }
  min = [tc].product([:north, :east, :south, :west]).filter { dist[_1] == dists.min }
  min.each { |m|
    u(map, prev, dist, m, sc)
  }
  map.sum{|a|a.count{_1==?O}}
end

require 'debug'
#puts part_two(ex)
#puts part_two(ex2)
puts part_two(input) # 496
