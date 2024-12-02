input = File.readlines("input/02", chomp: true)

ex = [
"7 6 4 2 1",
"1 2 7 8 9",
"9 7 6 2 1",
"1 3 2 4 5",
"8 6 4 4 1",
"1 3 6 7 9"
]

def safe?(l)
  dir = l[0] > l[-1] ? :dec : :inc
  l[1..].each.with_index(1) { |cur, i|
    prev = l[i-1]
    if (dir == :dec && prev < cur) || (dir == :inc && prev > cur) || ((prev-cur).abs < 1) || ((prev-cur).abs > 3)
      return i
    end
  }
  true
end

def part_one(input)
  input = input.map { _1.split.map(&:to_i) }
  input.count { safe?(_1) == true }
end

puts part_one(input) # 252

def part_two(input)
  input = input.map { _1.split.map(&:to_i) }
  input.count { |l|
    f = safe?(l)
    next true if f == true
    next true if safe?(l[...f]+l[f+1..]) == true
    f += 1
    next true if safe?(l[...f]+l[f+1..]) == true
    f -= 2
    safe?(l[...f]+l[f+1..]) == true
  }
end

puts part_two(input) # 324
