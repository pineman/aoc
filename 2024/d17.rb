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

#puts part_one(input) # 7,3,0,5,7,1,4,0,5

ex2 = <<-EX.split("\n").map(&:chomp)
Register A: 25371521910085
Register B: 0
Register C: 0

Program: 2,4, 1,1, 7,5, 4,6, 0,3, 1,4, 5,5, 3,0
EX
puts part_one(ex2) # 7,3,0,5,7,1,4,0,5

def part_two(input)
  a, b, c = input[..2].map { _1.match(/\d+/)[0].to_i }
  (0..15).to_a.each { |a|
    #a = (0b101110000000 << 3) + aa
    puts "0b%b" % a
    program = input[4][9..].split(?,).map(&:to_i)
    program += [-1, -1]
    pp program
    ip = 0
    out = []
    loop {
      opcode, op = program[ip..ip+1]
      case opcode
      when 0
        puts "adv: A = A 3>> = 0b%03b" % (a / 2**combo(op, a, b, c))
        a = a / 2**combo(op, a, b, c)
      when 1
        puts "bxl: B = B ^ 0b%03b = 0b%03b" % [op, (b ^ op)]
        b = b ^ op
      when 2
        puts "bst: B = A & 0b111 = 0b%03b" % (combo(op, a, b, c) % 8)
        b = combo(op, a, b, c) % 8
      when 3
        puts "jnz (A = 0b%03b)\n\n" % a
        ip = op - 2 if a != 0
      when 4
        puts "bxc: B = B ^ C = 0b%03b" % (b ^ c)
        b = b ^ c
      when 5
        puts "out: B & 0b111 = #{combo(op, a, b, c) % 8}"
        out << combo(op, a, b, c) % 8
      when 6
        puts "bdv: B = A #{combo(op, a, b, c)} >> = 0b%03b" % (a / 2**combo(op, a, b, c))
        b = a / 2**combo(op, a, b, c)
      when 7
        puts "cdv: C = A B>> = 0b%03b" % (a / 2**combo(op, a, b, c))
        c = a / 2**combo(op, a, b, c)
      when -1
        break
      end
      ip += 2
    }
    puts out.join(?,)
    puts
  }
end
#part_two(ex2)

def t(input, i, cur)
  (0..7).to_a.filter { |aa|
    a = (cur << 3) + aa
    #puts "0b%b" % a
    _, b, c = input[..2].map { _1.match(/\d+/)[0].to_i }
    program = input[4][9..].split(?,).map(&:to_i)
    goal = program.dup
    program += [-1, -1]
    ip = 0
    out = []
    loop {
      opcode, op = program[ip..ip+1]
      case opcode
      when 0
        #puts "adv: A = A 3>> = 0b%03b" % (a / 2**combo(op, a, b, c))
        a = a / 2**combo(op, a, b, c)
      when 1
        #puts "bxl: B = B ^ 0b%03b = 0b%03b" % [op, (b ^ op)]
        b = b ^ op
      when 2
        #puts "bst: B = A & 0b111 = 0b%03b" % (combo(op, a, b, c) % 8)
        b = combo(op, a, b, c) % 8
      when 3
        #puts "jnz (A = 0b%03b)\n\n" % a
        ip = op - 2 if a != 0
      when 4
        #puts "bxc: B = B ^ C = 0b%03b" % (b ^ c)
        b = b ^ c
      when 5
        #puts "out: B & 0b111 = #{combo(op, a, b, c) % 8}"
        out << combo(op, a, b, c) % 8
      when 6
        #puts "bdv: B = A #{combo(op, a, b, c)} >> = 0b%03b" % (a / 2**combo(op, a, b, c))
        b = a / 2**combo(op, a, b, c)
      when 7
        #puts "cdv: C = A B>> = 0b%03b" % (a / 2**combo(op, a, b, c))
        c = a / 2**combo(op, a, b, c)
      when -1
        break
      end
      ip += 2
    }
    #puts out.join(?,)
    #p out
    #p i
    #p goal[-1*i..]
    out == goal[-1*(i+1)..]
  }
end

def part_two(input)
  program = input[4][9..].split(?,).map(&:to_i)

  m = program.size
  i = 0
  paths = [[0, t(input, 1, 0)]]
  i += 1
  until i == m+1
    paths = paths.flat_map { |cur, pa|
      pa.map { |c| 
        new = (cur << 3) + c
        [new, t(input, i, new)]
      }
    }
    i+=1
  end
  paths.min_by { |a,b| a }[0]
end

puts part_two(ex2)

