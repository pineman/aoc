# https://www.reddit.com/r/adventofcode/comments/1hja685/2024_day_21_here_are_some_examples_and_hints_for/
# https://www.reddit.com/r/adventofcode/comments/1hjgyps/2024_day_21_part_2_i_got_greedyish/

input = File.readlines("input/21", chomp: true)

ex = %w[
029A
980A
179A
456A
379A
]

def to_map(a)
  a.map.with_index { |r, rr|
    r.map.with_index { |c, cc| 
      [c, [rr, cc]]
    }.to_h
  }.reduce(&:merge).filter { |k, v| k }
end

# +---+---+---+
# | 7 | 8 | 9 |
# +---+---+---+
# | 4 | 5 | 6 |
# +---+---+---+
# | 1 | 2 | 3 |
# +---+---+---+            
#     | 0 | A |
#     +---+---+
NUM_MAP = to_map([
  ['7', '8', '9'],
  ['4', '5', '6'],
  ['1', '2', '3'],
  [nil, '0', 'A']
])

#     +---+---+
#     | ^ | A |
# +---+---+---+
# | < | v | > |
# +---+---+---+
DIR_MAP = to_map([
  [nil, '^', 'A'],
  ['<', 'v', '>'],
])

def num_trans(code)
  rs, cs = NUM_MAP['A']
  s = ''
  code.chars.each { |char|
    re, ce = NUM_MAP[char]
    rd, cd = [re-rs, ce-cs]
    pp [NUM_MAP.find { |k, v| v == [rs, cs] }[0], char]
    c_dir = (cs < ce ? '>' : '<')
    if rs < re
      # start with horizontal movements
      s += c_dir * cd.abs
      s += 'v' * rd.abs
    elsif rs > re
      # start with vertical movements
      s += '^' * rd.abs
      s += c_dir * cd.abs
    else
      # only horizontal
      s += c_dir * cd.abs
    end
    s += 'A'
    puts s
    rs, cs = [re, ce]
  }
  s
end

def dir_trans(code)
  rs, cs = DIR_MAP['A']
  s = ''
  code.chars.each { |char|
    re, ce = DIR_MAP[char]
    rd, cd = [re-rs, ce-cs]
    pp [DIR_MAP.find { |k, v| v == [rs, cs] }[0], char]
    c_dir = (cs < ce ? '>' : '<')
    if rs < re
      # start with vertical movements
      s += 'v' * rd.abs
      s += c_dir * cd.abs
    elsif rs > re
      # start with horizontal movements
      s += c_dir * cd.abs
      s += '^' * rd.abs
    else
      # only horizontal
      s += c_dir * cd.abs
    end
    s += 'A'
    puts s
    rs, cs = [re, ce]
  }
  s
end

def shortest_seq_len(code)
  a = num_trans(code)
  #puts a
  b = dir_trans(a)
  puts b
  #c = dir_trans(b)
  #puts c
  #c.size
end

#ex.each { |code|
#  [code, shortest_seq_len(code)]
#}
[ex[0], shortest_seq_len(ex[0])]
#puts '<v<A>>^AvA^A<vA<AA>>^AAvA<^A>AAvA^A<vA>^AA<A>A<v<A>A>^AAAvA<^A>A'

#def part_one(input)
#end
#
#puts part_one(ex) # 126384

#puts part_one(input) 
