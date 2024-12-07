input = File.readlines("input/06", chomp: true)

ex = [
  "....#.....",
  ".........#",
  "..........",
  "..#.......",
  ".......#..",
  "..........",
  ".#..^.....",
  "........#.",
  "#.........",
  "......#...",
]

def find_pos(map)
  i, j = nil, nil
  map.each.with_index { |r, rr|
    if j = r.find_index(?^)
      i = rr
      break
    end
  }
  [i, j]
end

def _next(dir, i, j)
  case dir
  when ?^
    i -= 1
  when ?>
    j += 1
  when ?V
    i += 1
  when ?<
    j -= 1
  end
  [i, j]
end

def next_dir(dir)
  case dir
  when ?^
    ?>
  when ?>
    ?V
  when ?V
    ?<
  when ?<
    ?^
  end
end

def move!(map)
  i, j = find_pos(map)
  max_i = map.size
  max_j = map[0].size
  dir = map[i][j]
  loop do
    map[i][j] = ?X
    ii, jj = _next(dir, i, j)
    return if ii == -1 || ii == max_i || jj == -1 || jj == max_j
    if map[ii][jj] == ?#
      dir = next_dir(dir)
    else
      i, j = ii, jj
    end
  end
end

def part_one(input)
  map = input.map(&:chars)
  move!(map)
  map.sum { _1.count(?X) }
end

puts part_one(input) # 5067

def loop?(map, i, j, dir)
  max_i = map.size
  max_j = map[0].size
  oi, oj = i, j
  loop do
    map[i][j] = [?X, dir] unless map[i][j].is_a?(Array)
    ii, jj = _next(dir, i, j)
    return false if ii == -1 || ii == max_i || jj == -1 || jj == max_j
    return true if map[ii][jj] == [?X, dir]
    if map[ii][jj] == ?#
      dir = next_dir(dir)
    else
      i, j = ii, jj
    end
  end
end

def move_two!(map)
  i, j = find_pos(map)
  max_i = map.size
  max_j = map[0].size
  dir = map[i][j]
  loop_count = 0
  loop do
    map[i][j] = [?X, dir]
    ii, jj = _next(dir, i, j)
    return loop_count if ii == -1 || ii == max_i || jj == -1 || jj == max_j
    if map[ii][jj] == ?#
      dir = next_dir(dir)
    else
      if map[ii][jj] == ?.
        map_copy = map.map(&:clone)
        map_copy[ii][jj] = ?#
        loop_count += 1 if loop?(map_copy, i, j, next_dir(dir))
      end
      i, j = ii, jj
    end
  end
  loop_count
end

def part_two(input)
  map = input.map(&:chars)
  move_two!(map)
end

puts part_two(input) # 1793
