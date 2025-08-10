input = File.readlines("input/22", chomp: true)

ex = <<-EX.split("\n")
1
10
100
2024
EX

def mix_prune(s, n)
  (s ^ n) % 16777216
end

def next_secret(s)
  s = mix_prune(s, s << 6)
  s = mix_prune(s, s >> 5)
  mix_prune(s, s << 11)
end

def part_one(input)
  input.sum { |i|
    s = i.to_i
    2000.times { s = next_secret(s) }
    s
  }
end

#puts part_one(ex)
#puts part_one(input)

ex2 = <<-EX.split("\n")
1
2
3
2024
EX

def part_two(input)
  prices = input.map(&:to_i).map { |i|
    a = [{number: i, price: i % 10, delta: nil}]
    (1..2000).each { |j| 
      number = next_secret(a[j-1][:number])
      price = number % 10
      a[j] = {number:, price:, delta: price - a[j-1][:price]}
    }
    a
  }
  pre = prices.map { |p|
    s = {}
    p[1..].each_cons(4).each { |a| 
      d = a.map { _1[:delta] }
      s[d] = a[-1][:price] if !s.key?(d)
    }
    s
  }
  s = pre.flat_map(&:keys).to_set
  ss = {}
  s.each { |d|
    ss[d] = pre.map { _1[d] }.compact.sum
  }
  ss.sort_by { _2 }[-1][1]
end

def part_two(input)
  ss = Hash.new(0)
  input.map(&:to_i).each { |seed|
    prices = [seed].tap { |n| 2000.times { seed = next_secret(seed); n << seed } }.map { _1 % 10 }
    diffs = prices.each_cons(2).map { |a, b| b - a }
    s = {}
    diffs.each_cons(4).with_index { |d, i|
      if !s[d]
        ss[d] += prices[i+4]
        s[d] = 1
      end
    }
  }
  ss.max_by(&:last)
end

#p part_two(ex2) # 23
p part_two(input) # 2399
