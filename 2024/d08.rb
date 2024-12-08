input = File.readlines("input/08", chomp: true)

ex = [
  "............",
  "........0...",
  ".....0......",
  ".......0....",
  "....0.......",
  "......A.....",
  "............",
  "............",
  "........A...",
  ".........A..",
  "............",
  "............"
]

def part_one(input)
  map = input.map(&:chars)
  h = Hash.new { |hash, key| hash[key] = [] }
  map.each.with_index { |r, y|
    r.each.with_index { |c, x|
      next if c == ?. 
      h[c] << [x, y]
    }
  }
  mx = map[0].size - 1
  my = map.size - 1
  t = Set.new()
  h.each { |k, vv|
    vv.each { |v|
      others = vv - [v]
      others.each { |o|
        x, y = v
        ox, oy = o
        dx, dy = [x - ox, y - oy]
        adx, ady = [x - ox, y - oy].map(&:abs)
        check = case [dx, dy].map { _1 >= 0 ? 1 : -1 }
        when [1, 1]
          # se
          [x + adx, y + ady]
        when [1, -1]
          # ne
          [x + adx, y - ady]
        when [-1, 1]
          # sw
          [x - adx, y + ady]
        when [-1, -1]
          # nw
          [x - adx, y - ady]
        end
        cx, cy = check
        if cx >= 0 && cx <= mx && cy >= 0 && cy <= my
          t << check
          map[cy][cx] = ?# if map[cy][cx] == ?.
        end
      }
    }
  }
  t.count
end

puts part_one(input) # 308

def part_two(input)
  map = input.map(&:chars)
  h = Hash.new { |hash, key| hash[key] = [] }
  map.each.with_index { |r, y|
    r.each.with_index { |c, x|
      next if c == ?. 
      h[c] << [x, y]
    }
  }
  mx = map[0].size - 1
  my = map.size - 1
  t = Set.new()
  h.each { |k, vv|
    vv.each { |v|
      others = vv - [v]
      others.each { |o|
        x, y = v
        ox, oy = o
        dx, dy = [x - ox, y - oy]
        adx, ady = [x - ox, y - oy].map(&:abs)
        check = case [dx, dy].map { _1 >= 0 ? 1 : -1 }
        when [1, 1]
          # se
          [x + adx, y + ady]
        when [1, -1]
          # ne
          [x + adx, y - ady]
        when [-1, 1]
          # sw
          [x - adx, y + ady]
        when [-1, -1]
          # nw
          [x - adx, y - ady]
        end
        t << v
        a = [check]
        a.each { |c|
          cx, cy = c
          if cx >= 0 && cx <= mx && cy >= 0 && cy <= my
            t << c
            map[cy][cx] = ?# if map[cy][cx] == ?.
            a << case [dx, dy].map { _1 >= 0 ? 1 : -1 }
            when [1, 1]
              # se
              [cx + adx, cy + ady]
            when [1, -1]
              # ne
              [cx + adx, cy - ady]
            when [-1, 1]
              # sw
              [cx - adx, cy + ady]
            when [-1, -1]
              # nw
              [cx - adx, cy - ady]
            end
          end
        }
      }
    }
  }
  t.count
end

puts part_two(input) # 1147
