input = File.readlines("../input/11", chomp: true)[0]

ex = "0 1 10 99 999"
ex2 = "125 17"

def _blink(times, stone)
  return 1 if times == 0
  if stone == 0
    blink(times-1, 1)
  elsif (s = stone.to_s).size.even?
    a, b = [s[...s.size/2], s[s.size/2..]].map(&:to_i)
    blink(times-1, a) + blink(times-1, b)
  else
    blink(times-1, stone * 2024)
  end
end

@blink_cache = {}
def blink(times, stone)
  k = "#{times}-#{stone}"
  c = @blink_cache[k]
  return c if c
  res = _blink(times, stone)
  @blink_cache[k] = res
  res
end

def part_one(input)
  stones = input.split(" ").map(&:to_i)
  stones.sum { |stone|
    blink(25, stone)
  }
end

puts part_one(input) # 172484

def part_two(input)
  stones = input.split(" ").map(&:to_i)
  stones.sum { |stone|
    blink(75, stone)
  }
end

puts part_two(input) # 205913561055242
