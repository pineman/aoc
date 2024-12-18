input = File.readlines("input/17", chomp: true)

ex = <<-EX.split("\n").map(&:chomp)
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
EX

def combo(op, a, b, c)
  case op
  when 0..3
    op
  when 4
    a
  when 5
    b
  when 6
    c
  end
end

def part_one(input)
  a, b, c = input[..2].map { _1.match(/\d+/)[0].to_i }
  program = input[4][9..].split(?,).map(&:to_i)
  program += [-1, -1]
  pp program
  ip = 0
  out = []
  loop {
    opcode, op = program[ip..ip+1]
    case opcode
    when 0
      a = a / 2**combo(op, a, b, c)
    when 1
      b = b ^ op
    when 2
      b = combo(op, a, b, c) % 8
    when 3
      ip = op - 2 if a != 0
    when 4
      b = b ^ c
    when 5
      out << combo(op, a, b, c) % 8
    when 6
      b = a / 2**combo(op, a, b, c)
    when 7
      c = a / 2**combo(op, a, b, c)
    when -1
      break
    end
    ip += 2
  }
  out.join(?,)
end

puts part_one(input) # 7,3,0,5,7,1,4,0,5
