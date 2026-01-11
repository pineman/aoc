require 'debug'
input = File.readlines("input/01", chomp: true)

ex = <<-EX.split("\n")
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
EX

def part_one(input)
  r = 0
  s = 50
  input.each { |i|
    d = (i[1..].to_i) % 100
    dir = i[0]
    if dir == ?L
      s -= d
    else
      s += d
    end
    s = s % 100
    if s == 0
      r += 1
    end
  }
  r
end

puts part_one(input)

def part_two(input)
  r = 0
  s = 50
  input.each { |i|
    d = i[1..].to_i
    r += d / 100
    d = d % 100
    dir = i[0]
    if dir == ?L
      n = s - d
      if s != 0 && n < 0
        r += 1 
      end
    else
      n = s + d
      if s != 0 && n > 100
        r += 1
      end
    end
    s = n % 100
    if s == 0
      r += 1
    end
  }
  r
end

puts part_two(input)
