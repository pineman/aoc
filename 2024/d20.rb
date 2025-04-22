require "matrix"

input = File.readlines("input/20", chomp: true)

ex = <<-EX.split("\n")
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
EX

DIRS = [Vector[0, 1], Vector[1, 0], Vector[0, -1], Vector[-1, 0]]

def part_one(input)
  h = input.each_with_index.with_object({}) { |(r, i), h|
    r.chars.each_with_index { |c, j|
      h[Vector[i, j]] = c
    }
  }

  s, e = nil, nil
  h.each { |k, v|
    DIRS.each { |d|
      n = k+d
      if h[n] == ?S
        s = n
      elsif h[n] == ?E
        e = n
      end
    }
  }

  last = s
  lastc = 1
  loop {
    break if last == e
    DIRS.each { |d|
      new = last + d
      if h[new] == ?. || h[new] == ?E
        h[new] = lastc
        lastc += 1
        last = new
      end
    }
  }

  # a = Array.new(input[0].size) { Array.new(input.size) }
  # h.each { |k, v|
  #   i, j = k.to_a
  #   a[i][j] = v
  # }
  # pp a

  cheats = Set.new
  h.filter { |k, v| v.is_a?(Integer) }.sort_by { _2 }.each { |k, v|
    next if k == e
    #puts "checking #{[k, v]}"
    cheats.merge(cheat(h, s, e, k))
  }
  h[s] = 0
  cheats.merge(cheat(h, s, e, s))

  # pp cheats.group_by { |cs, ce|
  #   h[ce]-h[cs]-2
  # }.sort_by { |k, v| k }.map { |k, v| [k, v.size] }

  pp cheats.group_by { |cheat_start, cheat_end|
    h[cheat_end] - h[cheat_start] - 2
  }.sort_by { |k, v| k }.filter_map { |k, v| v.size if k >= 100 }.sum
end

def cheat(h, s, e, cheat_start, cur=nil, lvl=1)
  cheats = Set.new
  return cheats if lvl > 2
  DIRS.each { |d|
    new = (cur || cheat_start) + d
    if h[new] == ?#
      cheats.merge(cheat(h, s, e, cheat_start, new, lvl+1))
    elsif h[new].is_a?(Integer) && h[new] - lvl > h[cheat_start]
      #puts "found cheat #{{cheat_start:, cheat_start_v: h[cheat_start], new:, new_v: h[new], lvl:}}"
      cheats << [cheat_start, new]
    end
  }
  cheats
end

#part_one(ex)

part_one(input) # 1351

def part_two(input, min)
  h = input.each_with_index.with_object({}) { |(r, i), h|
    r.chars.each_with_index { |c, j|
      h[Vector[i, j]] = c
    }
  }

  s, e = nil, nil
  h.each { |k, v|
    DIRS.each { |d|
      n = k+d
      if h[n] == ?S
        s = n
      elsif h[n] == ?E
        e = n
      end
    }
  }

  l = s
  ll = 1
  loop {
    break if l == e
    DIRS.each { |d|
      n = l+d
      if h[n] == ?. || h[n] == ?E
        h[n] = ll
        ll += 1
        l = n
      end
    }
  }

  # a = Array.new(input[0].size) { Array.new(input.size) }
  # h.each { |k, v|
  #   i, j = k.to_a
  #   a[i][j] = v
  # }
  # pp a

  cheats = {c: Set.new, lvl: Hash.new(9999)}
  h[s] = 0
  cheat(cheats, h, s)
  h.filter { |k, v| v.is_a?(Integer) }.sort_by { _2 }.each { |k, v|
    next if k == e
    puts "checking #{[k, v]}"
    cheat(cheats, h, k)
  }

  pp cheats[:c].group_by { |cs, ce|
    h[ce]-h[cs]-cheats[:lvl][[cs, ce]]
  }.filter_map { |k, v| [v.size, k] if k >= min }.sort_by { _2 }

  # pp cheats[:c].group_by { |cs, ce|
  #   h[ce]-h[cs]-cheats[:lvl][[cs, ce]]
  # }.filter_map { |k, v| [v.size, k] if k >= min }.sum { |a,b| a }
end

def cheat(cheats, h, cs, cc=nil, lvl=1, v=Set.new)
  v.add(cs)
  return if lvl > 20
  DIRS.each { |d|
    n = (cc||cs)+d
    if h[n] == ?#
      puts "#{n} is lvl #{lvl}" if cs == Vector[3,2]
      cheat(cheats, h, cs, n, lvl+1, v.add(n))
    elsif cheats[:lvl][[cs, n]] > lvl && h[n].is_a?(Integer) && h[n] - lvl > h[cs]
      pp v if n == Vector[7,5]
      puts "found cheat #{{cs:, csv: h[cs], n:, nv: h[n], lvl:}}"
      cheats[:c] << [cs, n]
      cheats[:lvl][[cs, n]] = lvl
    end
  }
end

#part_two(ex, 50)
#part_two(input, 100)

#def dist(v1, v2)
#  x1, y1 = v1.to_a
#  x2, y2 = v2.to_a
#  (x1-x2).abs + (y1-y2).abs
#end

require 'algorithms'
include Containers

def s(h, s, e)
  q = PriorityQueue.new
  dist = Hash.new(Float::INFINITY)
  prev = Hash.new { |h, k| h[k] = [] }

  q.push(s, 0)
  dist[s] = 0

  while !q.empty?
    u = q.pop
    return [dist, prev] if u == e
    DIRS.each { |d|
      v = u+d
      new_dist = h[v].is_a?(Integer) ? 1 : 0 # maximize the amount of walls traversed
      new_dist = dist[u] + new_dist
      if new_dist < dist[v]
        dist[v] = new_dist
        prev[v] << u
        q.push(v, -new_dist) # TODO: review "distances" are correct, esp. sign
      end
    }
  end
end

def part_two2(input, min)
  h = input.each_with_index.with_object({}) { |(r, i), h|
    r.chars.each_with_index { |c, j|
      h[Vector[i, j]] = c
    }
  }

  s, e = nil, nil
  h.each { |k, v|
    DIRS.each { |d|
      n = k+d
      if h[n] == ?S
        s = n
      elsif h[n] == ?E
        e = n
      end
    }
  }

  l = s
  ll = 1
  loop {
    break if l == e
    DIRS.each { |d|
      n = l+d
      if h[n] == ?. || h[n] == ?E
        h[n] = ll
        ll += 1
        l = n
      end
    }
  }
  h[s] = 0

  a = Array.new(input[0].size) { Array.new(input.size) }
  h.each { |k, v|
    i, j = k.to_a
    a[i][j] = v
  }
  pp a

  h.each { |sk, sv|
    h.filter { |k, v|
      v.is_a?(Integer) && dist(sk, k) <= 20
    }.each { |k, v|
      # TODO: get the path that maximizes the number of # we visited
      #  or alternatively minimizes the number of Integers we visited
      dist, prev = s(h, sk, k)
      dist[k]
    }
  }
end

part_two2(ex, 50)

