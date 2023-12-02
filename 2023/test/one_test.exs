defmodule Aoc.One.Test do
  use ExUnit.Case

  describe "AoC 2023 day one" do
    test "part one" do
      input = Aoc.get_input("one")
      assert Aoc.One.part_one(input) == 54940
    end

    test "translate" do
      input = [
        ~w(two1nine 219),
        ~w(eightwothree 8wo3),
        ~w(abcone2threexyz abc123xyz),
        ~w(xtwone3four x2ne34),
        ~w(4nineeightseven2 49872),
        ~w(zoneight234 z1ight234),
        ~w(7pqrstsixteen 7pqrst6teen)
      ]

      input
      |> Enum.each(fn [input, output] ->
        assert Aoc.One.translate(input) == output
      end)
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
