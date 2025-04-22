input = File.readlines("input/25", chomp: true)

ex = <<-EX.split("\n")
#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
EX

def part_one(input)
  locks, keys = input
    .chunk(&:empty?)
    .reject { it[0] }
    .map { it[1] }
    .partition { it[0] == "#####" }
  locks = locks.map { |lock| lock.map(&:chars).transpose.map { it.count(?#)-1 } }
  keys = keys.map { |key| key.map(&:chars).transpose.map { it.count(?#)-1 } }
  s = Set.new
  locks.product(keys).each { |lock, key|
    if lock.zip(key).all? { it.sum <= 5 }
      s.add([lock, key])
    end
  }
  s.count
end

#puts part_one(ex)
puts part_one(input) # 3249
