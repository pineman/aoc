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
require 'benchmark'
def part_one(input)
  towels, *designs = input.reject(&:empty?)
  towels = towels.split(?,).map(&:strip)
  designs.count { |design|
    p design
    s = Set.new(design.chars)
    t = towels.filter { |towel| towel.chars.all? { s.include?(_1) } }

    tes = Set.new
    t.filter { design.start_with?(_1) }.find { |st|
      (0..design.size-st.size).find { |i| 
        t.repeated_permutation(i).find {
          te = st + _1.join[...design.size-st.size]
          next if te.size != design.size || !tes.add?(te)
          te == design
        }
      }
    }
  }
end

#puts part_one(ex)
puts part_one(input)
