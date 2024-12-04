input = File.readlines("input/04", chomp: true)

ex = [
  "MMMSXXMASM",
  "MSAMXMSMSA",
  "AMXSXMAAMM",
  "MSAMASMSMX",
  "XMASAMXAMM",
  "XXAMMXXAMA",
  "SMSMSASXSS",
  "SAXAMASAAA",
  "MAMMMXMMMM",
  "MXMXAXMASX"
]

require("matrix")

def dd(input)
  o = []
  s = input.size
  m = Matrix[*input.map(&:chars)]
  (1...s).each { |i|
    o << m.minor(s-i, i, 0, i).collect(:diagonal).to_a.join
  }
  o << m.collect(:diagonal).to_a.join
  (1...s).to_a.reverse.each { |i|
    o << m.minor(0, i, s-i, i).collect(:diagonal).to_a.join
  }
  o
end

def part_one(input)
  input_t = input.map(&:chars).transpose.map(&:join)
  h = input
  hr = h.map(&:reverse)
  v = input_t
  vr = v.map(&:reverse)
  d = dd(input)
  dr = d.map(&:reverse)
  dm = dd(hr) # m: mirrored matrix - its diagonal is the original's secondary diagonal
  dmr = dm.map(&:reverse)
  h.sum { _1.scan(/XMAS/).count } + 
    hr.sum { _1.scan(/XMAS/).count } + 
    v.sum { _1.scan(/XMAS/).count } + 
    vr.sum { _1.scan(/XMAS/).count } + 
    d.sum { _1.scan(/XMAS/).count } + 
    dr.sum { _1.scan(/XMAS/).count } +
    dm.sum { _1.scan(/XMAS/).count } +
    dmr.sum { _1.scan(/XMAS/).count }
end

puts part_one(input) # 2599

def part_two(input)
  m = input.map(&:chars)
  s = input.size
  t = 0
  for i in 1..(s-2)
    for j in 1..(s-2)
      next unless m[i][j] == "A"
      nw = m[i-1][j-1]
      ne = m[i-1][j+1]
      sw = m[i+1][j-1]
      se = m[i+1][j+1]
      mas_pattern = nw+ne+sw+se
      if ["MSMS", "MMSS", "SMSM", "SSMM"].include?(mas_pattern)
        t += 1
      end
    end
  end
  t
end

puts part_two(input) # 1948
