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
    cando = false
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

puts part_one(input) # 1479679

def can?(map, boxes, dir, i, j)
  mi = map.size
  mj = map[0].size
  puts "can? dir: #{dir}, i,j: #{i},#{j}"
  ni, nj = case dir
  when ?^
    [i-1, j]
  when ?v
    [i+1, j]
  when ?>
    [i, j+1]
  when ?<
    [i, j-1]
  end

  return [true, ni, nj, []] if map[ni][nj] == ?.
  return [false, i, j, []] if map[ni][nj] == ?#

  if dir == ?^ || dir == ?v
    bboxes = Set.new([{l: [ni, nj], r: [ni, nj+1]}, {r: [ni, nj], l: [ni, nj-1]}]) & boxes
    pp [dir, bboxes]
    if bboxes.size > 1
      puts map.map(&:join).join("\n")
      puts "wat2"
      exit 1
    end
    if (b = bboxes.first)
      canr, _, _, rbboxes = can?(map, boxes, dir, *b[:r])
      canl, _, _, lbboxes = can?(map, boxes, dir, *b[:l])
      if canr && canl
        bboxes.merge(rbboxes)
        bboxes.merge(lbboxes)
        return [true, ni, nj, bboxes]
      else
        return [false, i, j, []]
      end
    end
    puts "wat"
    exit 1
  else
    cando = true
    bboxes = Set.new
    case dir
    when ?>
      a = nj
      while a <= mj
        break (cando = false) if map[ni][a] == ?#
        break (cando = true) if map[ni][a] == ?.
        bboxes << {l: [ni, a], r: [ni, a+1]}
        a += 2
      end
    when ?<
      a = nj
      while a >= 0
        p map[ni][a]
        break (cando = false) if map[ni][a] == ?#
        break (cando = true) if map[ni][a] == ?.
        bboxes << {r: [ni, a], l: [ni, a-1]}
        a -= 2
      end
    end
    if cando
      return [true, ni, nj, bboxes]
    else
      return [false, i, j, bboxes]
    end
  end
end

def asdf(map, boxes, bboxes, dir)
  boxes.subtract(bboxes)
  bboxes.each { |box|
    box => {r: [ri, rj], l: [li, lj]}
    map[ri][rj] = ?.
    map[li][lj] = ?.
  }
  bboxes.each { |box|
    box => {r: [ri, rj], l: [li, lj]}
    newbox = {r:
    case dir
    when ?^
      [ri-1, rj]
    when ?v
      [ri+1, rj]
    when ?>
      [ri, rj+1]
    when ?<
      [ri, rj-1]
    end, 
    l:
    case dir
    when ?^
      [li-1, lj]
    when ?v
      [li+1, lj]
    when ?>
      [li, lj+1]
    when ?<
      [li, lj-1]
    end
    }
    newbox => {r: [ri, rj], l: [li, lj]}
    map[li][lj] = ?[
    map[ri][rj] = ?]
    boxes << newbox
  }
end

def move2!(map, dir, i, j, boxes)
  mi = map.size
  mj = map[0].size

  can, ni, nj, bboxes = can?(map, boxes, dir, i, j)
  puts "can? ret: #{[can, ni, nj, bboxes]}"
  if can && bboxes.any?
    # move boxes - remove from boxes set, insert new ones
    asdf(map, boxes, bboxes, dir)
  end

  map[i][j] = ?.
  map[ni][nj] = ?@
  [ni, nj]
end

def part_two(input)
  s = input.index("")
  map, moves = input[...s].map(&:chars), input[(s+1)..].join.chars
  nmap = Array.new(map.size) { Array.new(map[0].size*2, nil) }
  i, j = 0
  boxes = Set.new
  map.each.with_index { |r, ii|
    r.each.with_index { |c, jj|
      a, b = case map[ii][jj]
      when ?#
        [?#, ?#]
      when ?O
        boxes << {l: [ii, jj*2], r: [ii, jj*2+1]}
        [?[, ?]]
      when ?.
        [?., ?.]
      when ?@
        i, j = [ii, 2*jj]
        [?@, ?.]
      end
      nmap[ii][2*jj] = a
      nmap[ii][2*jj+1] = b
    }
  }
  map = nmap

  moves.each { |dir|
    s = nmap.map(&:join).join("\n")
    puts s
    exit 1 if s.include?("[.") || s.include?(".]")
    i, j = move2!(map, dir, i, j, boxes)
  }

  t = 0
  map.each.with_index { |r, ii|
    r.each.with_index { |c, jj|
      t += 100*ii+jj if c == ?[
    }
  }
  t
end

puts part_two(input) # 1509780
