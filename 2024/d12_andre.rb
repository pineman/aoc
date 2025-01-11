# https://raw.githubusercontent.com/andreccosta/advent-of-code/refs/heads/main/2024/day12/part2.rb
require 'matrix'

DIRS = [
  Vector[0, 1],
  Vector[1, 0],
  Vector[0, -1],
  Vector[-1, 0]
]

lines = File.readlines("input.txt", chomp: true)

map = lines.each_with_index.with_object({}) { |(line, y), g|
  line.chars.each_with_index { |c, x|
    g[Vector[y, x]] = c
  }
}

seen = Set.new
regions = map.keys.each_with_object([]) { |p, regions|
  next if seen.include?(p)

  regions << Set.new
  queue = [p]

  while curr = queue.shift
    next if regions.last.include?(curr)
    regions.last << curr
    seen << curr

    DIRS.each { |d|
      queue << (curr + d) if(map[curr + d] == map[curr])
    }
  end
}

r = regions.sum { |r|
  r.size * r.each.with_object(Set.new) { |p, sides|
    DIRS.each { |dir|
      next if r.include?(p + dir) # next if we're not at the border
      curr = p
      walk_dir = Vector[dir[1], -dir[0]] # walk_dir is perpendicular to dir (if we're checking N, walk_dir is E)

      # while (next is adjacent in the face direction) && (next is also on the border, checking perp. dir)
      while r.include?(curr + walk_dir) && !r.include?(curr + dir + walk_dir)
        curr += walk_dir # expand till we find the end of the face
      end

      sides << [curr, dir] # add the end of the face to set
      # if we're dropped e.g. here:
      #  |
      #  V
      # AAA
      # ABA
      # AAA
      # we'll get (0,2) in the E dir, and (0,0) in the W dir. all the first row 
      # will be visited. so start over on e.g. (1,2), get (2,2) in S and (0,2) in N.
      # but (0,2) is already in the set! so its not counted twice.
      # and so on.
    }
  }.size
}

p r
