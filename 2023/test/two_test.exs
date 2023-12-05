defmodule Aoc.Two.Test do
  use ExUnit.Case
  import Aoc.Two

  describe "AoC 2023 day two" do
    test "part one" do
      input = Aoc.get_input("two")
      assert part_one(input) == 2683
    end

    test "part two" do
      input = Aoc.get_input("two")
      assert part_two(input) == 49710
    end
  end
end
