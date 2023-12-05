defmodule Aoc.Three.Test do
  use ExUnit.Case
  import Aoc.Three

  describe "AoC 2023 day three" do
    test "part one" do
      input = ~w(
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        )
      assert part_one(input) == 4361
      input = Aoc.get_input("three")
      assert part_one(input) == 539_637
    end

    test "part two" do
      input = ~w(
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        )
      assert part_two(input) == 467_835
      input = Aoc.get_input("three")
      assert part_two(input) == 82_818_007
    end
  end
end
