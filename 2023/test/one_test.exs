defmodule Aoc.One.Test do
  use ExUnit.Case

  describe "AoC 2023 day one" do
    test "part one" do
      input = Aoc.get_input("one")
      assert Aoc.One.part_one(input) == 54940
    end

    test "part two" do
      input = Aoc.get_input("one")
      assert Aoc.One.part_two(input) == 54208
    end

    test "part two" do
      input = [
        "two1nine",
        "eightwothree",
        "abcone2threexyz",
        "xtwone3four",
        "4nineeightseven2",
        "zoneight234",
        "7pqrstsixteen"
      ]

      assert Aoc.One.part_two(input) == 281
    end
  end
end
