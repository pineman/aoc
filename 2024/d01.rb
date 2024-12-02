input = File.readlines("input/01", chomp: true)

def part_one(input)
  a, b = input.map { _1.split.map(&:to_i) }.transpose
  a.sort.zip(b.sort).map { |aa, bb|
    (aa - bb).abs
  }.sum
end

puts part_one(input)

def part_two(input)
  a, b = input.map { _1.split.map(&:to_i) }.transpose
  b = b.tally
  a.reduce(0) { |acc, c| acc += c * (b[c] || 0) }
end

puts part_two(input)
