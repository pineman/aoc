input = File.readlines("input/19", chomp: true)

ex = [
  "r, wr, b, g, bwu, rb, gb, br",
  "",
  "brwrr",
  "bggr",
  "gbbr",
  "rrbgbr",
  "ubwu",
  "bwurrg",
  "brgr",
  "bbrgwb"
]

$c = {}
def m(design, t)
  return $c[[design, t]] if $c.key?([design, t])
  r = _m(design, t)
  $c[[design, t]] = r
  r
end

def _m(design, t)
  return true if design.empty?
  f = t.filter { |tt| design.start_with?(tt) }
  return false if f.empty?
  f.find { |ff| m(design[ff.size..], t) }
end

def part_one(input)
  towels, *designs = input.reject(&:empty?)
  towels = towels.split(?,).map(&:strip)
  designs.count { |design|
    s = Set.new(design.chars)
    t = towels.filter { |towel| towel.chars.all? { s.include?(_1) } }
    m(design, t)
  }
end

#puts part_one(ex)
puts part_one(input) # 302

$c = {}
def m(design, t)
  return $c[[design, t]] if $c.key?([design, t])
  r = _m(design, t)
  $c[[design, t]] = r
  r
end

def _m(design, t)
  return 1 if design.empty?
  f = t.filter { |tt| design.start_with?(tt) }
  return 0 if f.empty?
  f.flat_map { |ff| m(design[ff.size..], t) }.sum
end

def part_two(input)
  towels, *designs = input.reject(&:empty?)
  towels = towels.split(?,).map(&:strip)
  designs.sum { |design|
    s = Set.new(design.chars)
    t = towels.filter { |towel| towel.chars.all? { s.include?(_1) } }
    m(design, t)
  }
end

#puts part_two(ex)
puts part_two(input) # 771745460576799
