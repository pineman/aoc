input = File.readlines("input/13", chomp: true)

ex = [
  "Button A: X+94, Y+34",
  "Button B: X+22, Y+67",
  "Prize: X=8400, Y=5400",
  "",
  "Button A: X+26, Y+66",
  "Button B: X+67, Y+21",
  "Prize: X=12748, Y=12176",
  "",
  "Button A: X+17, Y+86",
  "Button B: X+84, Y+37",
  "Prize: X=7870, Y=6450",
  "",
  "Button A: X+69, Y+23",
  "Button B: X+27, Y+71",
  "Prize: X=18641, Y=10279"
]

require 'matrix'

def part_one(input)
  input.chunk(&:empty?).filter_map { |v, c| c if !v }.filter_map { |c|
    a1, a2, b = c.map { _1.scan(/(\d+).*?(\d+)/)[0].map(&:to_i) } 
    sol = (Matrix.rows([b]) * Matrix.rows([a1, a2]).inverse).row(0)
    solvable = sol.map { _1.denominator }.to_a == [1, 1]
    if solvable
      a, b = sol.to_a.map(&:to_i)
      3*a + b
    end
  }.sum
end

#puts part_one(ex)
puts part_one(input)

def part_two(input)
  input.chunk(&:empty?).filter_map { |v, c| c if !v }.filter_map { |c|
    a1, a2, b = c.map { _1.scan(/(\d+).*?(\d+)/)[0].map(&:to_i) } 
    b = b.map { _1 + 10000000000000 }
    sol = (Matrix.rows([b]) * Matrix.rows([a1, a2]).inverse).row(0)
    solvable = sol.map { _1.denominator }.to_a == [1, 1]
    if solvable
      a, b = sol.to_a.map(&:to_i)
      3*a + b
    end
  }.sum
end

puts part_two(input)
