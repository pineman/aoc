input = File.readlines("input/01", chomp: true)

ex = [
"3   4",
"4   3",
"2   5",
"1   3",
"3   9",
"3   3"
]

def part_one(input)
  a, b = input.map { _1.split.map(&:to_i) }.transpose
  a.sort.zip(b.sort).map { |aa, bb|
    (aa - bb).abs
  }.sum
end

puts part_one(input) # 1151792

def part_two(input)
  a, b = input.map { _1.split.map(&:to_i) }.transpose
  b = b.tally
  a.reduce(0) { |acc, c| acc += c * (b[c] || 0) }
end

puts part_two(input) # 21790168
