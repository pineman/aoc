input = File.readlines("input/24", chomp: true)

ex = <<-EX.split("\n")
x00: 1
x01: 0
x02: 1
x03: 1
x04: 0
y00: 1
y01: 1
y02: 1
y03: 1
y04: 1

ntg XOR fgs -> mjb
y02 OR x01 -> tnw
kwq OR kpj -> z05
x00 OR x03 -> fst
tgd XOR rvg -> z01
vdt OR tnw -> bfw
bfw AND frj -> z10
ffh OR nrd -> bqk
y00 AND y03 -> djm
y03 OR y00 -> psh
bqk OR frj -> z08
tnw OR fst -> frj
gnj AND tgd -> z11
bfw XOR mjb -> z00
x03 OR x00 -> vdt
gnj AND wpb -> z02
x04 AND y00 -> kjc
djm OR pbm -> qhw
nrd AND vdt -> hwm
kjc AND fst -> rvg
y04 OR y02 -> fgs
y01 AND x02 -> pbm
ntg OR kjc -> kwq
psh XOR fgs -> tgd
qhw XOR tgd -> z09
pbm OR djm -> kpj
x03 XOR y03 -> ffh
x00 XOR y04 -> ntg
bfw OR bqk -> z06
nrd XOR fgs -> wpb
frj XOR qhw -> z04
bqk OR frj -> z07
y03 OR x01 -> nrd
hwm AND bqk -> z03
tgd XOR rvg -> z12
tnw OR pbm -> gnj
EX

def part_one(input)
  reg = {}
  r, gates = input.chunk(&:empty?).filter_map { |c, v| v if !c }
  r.each { |s| k, v = s.split(?:); reg[k] = v.to_i }
  gates.map! { |g|
    i, dst = g.split("->").map(&:strip)
    a, op, b = i.split
    [a, op, b, dst]
  }
  done = Set.new
  loop do
    gatesq = gates.filter { |a, op, b, dst|
      next if done.include?([a, op, b, dst])
      reg[a] && reg[b]
    }
    break if gatesq.empty?
    gatesq.each { |a, op, b, dst|
      done << [a, op, b, dst]
      res = case op
      when 'OR'
        reg[a] | reg[b]
      when 'XOR'
        reg[a] ^ reg[b]
      when 'AND'
        reg[a] & reg[b]
      end
      reg[dst] = res
    }
  end
  #puts reg.filter { |k, _| k[0] == ?x }.sort_by { |k, v| k }.map { |k, v| v }.reverse.join
  #puts reg.filter { |k, _| k[0] == ?y }.sort_by { |k, v| k }.map { |k, v| v }.reverse.join
  #puts reg.filter { |k, _| k[0] == ?z }.sort_by { |k, v| k }.map { |k, v| v }.reverse.join
  reg.filter { |k, _| k[0] == ?z }.sort_by { |k, v| k }.map { |k, v| v }.reverse.join.to_i(2)
end

#puts part_one(ex)
#puts part_one(input)

def part_two(input)
  reg = {}
  r, gates = input.chunk(&:empty?).filter_map { |c, v| v if !c }
  r.each { |s| k, v = s.split(?:); reg[k] = v.to_i }
  gates.map! { |g|
    i, dst = g.split("->").map(&:strip)
    a, op, b = i.split
    [a, op, b, dst]
  }

  pp gates.filter { |a, op, b, c| c[0] == ?z }
  #pp gates.filter { |a, op, b, c| a[0] == ?x || a[0] == ?y || b[0] == ?x || b[0] == ?y }
  exit 1

  done = Set.new
  loop do
    gatesq = gates.filter { |a, op, b, dst|
      next if done.include?([a, op, b, dst])
      reg[a] && reg[b]
    }
    break if gatesq.empty?
    gatesq.each { |a, op, b, dst|
      done << [a, op, b, dst]
      res = case op
      when 'OR'
        reg[a] | reg[b]
      when 'XOR'
        reg[a] ^ reg[b]
      when 'AND'
        reg[a] & reg[b]
      end
      reg[dst] = res
    }
  end
  #puts reg.filter { |k, _| k[0] == ?x }.sort_by { |k, v| k }.map { |k, v| v }.reverse.join
  #puts reg.filter { |k, _| k[0] == ?y }.sort_by { |k, v| k }.map { |k, v| v }.reverse.join
  #puts reg.filter { |k, _| k[0] == ?z }.sort_by { |k, v| k }.map { |k, v| v }.reverse.join
  reg.filter { |k, _| k[0] == ?z }.sort_by { |k, v| k }.map { |k, v| v }.reverse.join.to_i(2)
end

puts part_two(input)
