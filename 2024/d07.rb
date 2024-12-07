input = File.readlines("input/07", chomp: true)

ex = [
  "190: 10 19",
  "3267: 81 40 27",
  "83: 17 5",
  "156: 15 6",
  "7290: 6 8 6 15",
  "161011: 16 10 13",
  "192: 17 8 14",
  "21037: 9 7 18 13",
  "292: 11 6 16 20"
]

def parse(input)
  input.map { |l| t, n = l.split(':'); [t.to_i, n.split(' ').map(&:to_i)] }
end

def part_one(input)
  eqs = parse(input)
  eqs.filter { |total, nums| 
    [:+, :*].repeated_permutation(nums.size - 1).find { |per|
      r = nums[0]
      nums[1..].each.with_index { |num, i| r = r.send(per[i], num) }
      total == r
    }
  }.sum { |total, _| total }
end

puts part_one(input) # 303876485655

def part_two(input)
  eqs = parse(input)
  eqs.filter { |total, nums| 
    ['+', '*', '||'].repeated_permutation(nums.size - 1).find { |per|
      r = nums[0]
      nums[1..].each.with_index { |num, i| 
        r = case per[i]
            when '+'
              r += num
            when '*'
              r *= num
            when '||'
              r = r * (10 ** num.to_s.size) + num
            end
      }
      total == r
    }
  }.sum { |total, _| total }
end

puts part_two(input) # 146111650210682
