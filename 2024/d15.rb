input = File.readlines("input/15", chomp: true)

ex = <<-EX.split("\n")
########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########

<^^>>>vv<v>>v<<
EX

ex2 = <<-EX.split("\n")
##########
#..O..O.O#
#......O.#
#.OO..O.O#
#..O@..O.#
#O#..O...#
#O..O..O.#
#.OO.O.OO#
#....O...#
##########

<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
EX

def move!(map, m, i, j)
  mi = map.size
  mj = map[0].size

  ni, nj = case m
  when ?^
    [i-1, j]
  when ?v
    [i+1, j]
  when ?>
    [i, j+1]
  when ?<
    [i, j-1]
  end

  case map[ni][nj]
  when ?O
    cando = nil
    case m
    when ?^
      ni.step(0, -1).each { |a|
        break if map[a][nj] == ?#
        if map[a][nj] == ?.
          cando = [a, nj]
          break
        end
      }
    when ?v
      ni.step(mi, 1).each { |a|
        break if map[a][nj] == ?#
        if map[a][nj] == ?.
          cando = [a, nj]
          break
        end
      }
    when ?>
      nj.step(mj, 1).each { |a|
        break if map[ni][a] == ?#
        if map[ni][a] == ?.
          cando = [ni, a]
          break
        end
      }
    when ?<
      nj.step(0, -1).each { |a|
        break if map[ni][a] == ?#
        if map[ni][a] == ?.
          cando = [ni, a]
          break
        end
      }
    end
    if cando
      ei, ej = cando
      map[ei][ej] = ?O
      map[i][j] = ?.
      map[ni][nj] = ?@
    else
      ni, nj = [i, j]
    end
  when ?.
    map[i][j] = ?.
    map[ni][nj] = ?@
  when ?#
    ni, nj = [i, j]
  end

  [ni, nj]
end

def part_one(input)
  s = input.index("")
  map, moves = input[...s].map(&:chars), input[(s+1)..].join.chars
  i, j = 0
  map.each.with_index { |r, ii|
    r.each.with_index { |c, jj|
      i, j = [ii, jj] if c == "@"
    }
  }
  moves.each { |m|
    i, j = move!(map, m, i, j)
  }
  t = 0
  map.each.with_index { |r, ii|
    r.each.with_index { |c, jj|
      t += 100*ii+jj if c == ?O
    }
  }
  t
end

puts part_one(ex)
puts part_one(ex2)
puts part_one(input)
