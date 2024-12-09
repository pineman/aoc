input = File.readlines("input/09", chomp: true)[0]

ex = 2333133121414131402
ex2 = 12345

def part_one(input)
  s = input.to_s.chars.map(&:to_i).flat_map.with_index { |c, i|
    if i.even?
      [i/2] * c
    else
      [-1] * c
    end
  }
  i, j = 0, s.size - 1
  while i < j do
    if s[i] == -1 && s[j] != -1
      s[i], s[j] = s[j], s[i]
      i += 1 
      j -= 1
    else
      i += 1 if s[i] != -1
      j -= 1 if s[j] == -1
    end
  end
  s.filter { _1 != -1 }.map.with_index { |c, i| i * c }.sum
end

puts part_one(input) # 6471961544878

def fits?(space, s, e)
  size = e - s + 1
  i = space.find_index { _3 >= size && _2 < s}
  return unless i
  found = space[i]
  if found[2] == size
    space.delete_at(i)[0]
  else
    space[i] = [found[0]+size, found[1], found[2]-size]
    found[0]
  end
end

def part_two(input)
  disk = input.to_s.chars.map(&:to_i).flat_map.with_index { |c, i| [ i.even? ? i/2 : -1 ] * c }
  h = Hash.new { |h, k| h[k] = [] }
  disk.each.with_index { |n, i| h[n] << i }
  space = h.delete(-1).chunk_while { _2 - _1 == 1 }.map { [_1[0], _1[-1], _1.size] }
  ind = h.transform_values { [_1[0], _1[-1]] }.to_a
  ind.reverse.each { |n, (s, e)|
    if l = fits?(space, s, e)
      (e - s + 1).times { |x|
        disk[l+x], disk[s+x] = disk[s+x], disk[l+x]
      }
    end
  }
  disk.map.with_index { |c, i| i * c if c != -1 }.compact.sum
end

puts part_two(input) # 6511178035564
