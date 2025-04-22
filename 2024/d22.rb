input = File.readlines("input/22", chomp: true)

ex = <<-EX.split("\n")
1
10
100
2024
EX

def mix_prune(s, n)
  (s ^ n) % 16777216
end

def next_secret(s)
  s = mix_prune(s, s << 6)
  s = mix_prune(s, s >> 5)
  mix_prune(s, s << 11)
end

def part_one(input)
  input.sum { |i|
    s = i.to_i
    2000.times { s = next_secret(s) }
    s
  }
end

#puts part_one(ex)
puts part_one(input)
