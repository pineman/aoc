input = File.readlines("input/03", chomp: true)

ex = ["xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"]

def part_one(input)
  input.flat_map { |l|
    l.scan(/mul\(([0-9]{1,3},[0-9]{1,3})\)/).map { |m| a, b = m[0].split(",").map(&:to_i); a * b }
  }.sum
end

puts part_one(input) # 157621318

ex = ["xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"]
MAX = "mul(xxx,yyy)".size
def part_two(input)
  t = 0
  mul = true
  input.each { |l|
    l += "a" * MAX # padding
    l.chars.each_cons(MAX) { |c|
      c = c.join
      case c
      when /^mul\([0-9]{1,3},[0-9]{1,3}\)/
        next unless mul
        t += c.match(/mul\(([0-9]{1,3},[0-9]{1,3})\)/)[1].split(",").map(&:to_i).reduce(&:*)
      when /^do\(\)/
        mul = true
      when /^don't\(\)/
        mul = false
      end
    }
  }
  t
end

puts part_two(input) # 79845780
