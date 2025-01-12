input = File.readlines("input/14", chomp: true)

ex = [
  "p=0,4 v=3,-3",
  "p=6,3 v=-1,-3",
  "p=10,3 v=-1,2",
  "p=2,0 v=2,-1",
  "p=0,0 v=1,3",
  "p=3,0 v=-2,-2",
  "p=7,6 v=-1,-3",
  "p=3,0 v=-1,-2",
  "p=9,3 v=2,3",
  "p=7,3 v=-1,2",
  "p=2,4 v=2,-3",
  "p=9,5 v=-3,-3"
]

def part_one(input, mi, mj)
  r = input.map { |l| l.split.map { _1[2..].split(",").map(&:to_i).reverse } }

  100.times {
    r.map! { |p, v|
      pi, pj = p
      vi, vj = v
      npi, npj = [(pi + vi) % (mi), (pj + vj) % (mj)]
      [[npi, npj], v]
    }
  }

  hmi, hmj = [mi/2, mj/2]
  a, b, c, d = [0, 0, 0, 0]
  map = Array.new(mi) { Array.new(mj, 0) }
  r.each { |p, _|
    i, j = p
    if i < hmi
      if j < hmj
        a += 1
      elsif j > hmj
        b += 1
      end
    elsif i > hmi
      if j < hmj
        c += 1
      elsif j > hmj
        d += 1
      end
    end
  }
  [a, b, c, d].reduce(:*)
end

#puts part_one(ex, 7, 11)
puts part_one(input, 103, 101) # 222901875

def part_two(input, mi, mj)
  r = input.map { |l| l.split.map { _1[2..].split(",").map(&:to_i).reverse } }
  hmi, hmj = [mi/2, mj/2]
  iter = 0
  loop {
    r.map! { |p, v|
      pi, pj = p
      vi, vj = v
      npi, npj = [(pi + vi) % (mi), (pj + vj) % (mj)]
      [[npi, npj], v]
    }
    iter += 1

    map = Array.new(mi) { Array.new(mj, ?.) }
    r.each { |p, _|
      i,j=p
      map[i][j] = 0
    }
    maybe_tree = map.find { |row|
      t, p = [0, nil]
      row.each.with_index { |c, i|
        if c == 0
          if p == i - 1
            t += 1
          else
            t = 1
          end
          p = i
        else
          p = nil
        end
      }
      t >= 7
    }
    if maybe_tree
      puts map.map(&:join).join("\n")
      puts "iter: #{iter}"
    end
  }
end

puts part_two(input, 103, 101)
