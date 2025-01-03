defmodule Aoc.One do
  use Aoc

  def first_last_matching(line, regex) do
    Regex.scan(regex, line)
    |> List.flatten()
    # could use capture: :all_but_first to avoid this Enum.reject caused by the
    # part two regex, but then it breaks the part one regex as well.
    |> Enum.reject(&(&1 == ""))
    |> (fn l -> "#{List.first(l)}#{List.last(l)}" end).()
    |> to_integer()
  end

  def to_integer(s) do
    s
    |> String.replace("one", "1")
    |> String.replace("two", "2")
    |> String.replace("three", "3")
    |> String.replace("four", "4")
    |> String.replace("five", "5")
    |> String.replace("six", "6")
    |> String.replace("seven", "7")
    |> String.replace("eight", "8")
    |> String.replace("nine", "9")
    |> String.to_integer()
  end

  def part_one(input) do
    regex = ~r/\d/

    input
    |> Enum.map(&first_last_matching(&1, regex))
    |> Enum.reduce(&+/2)
  end

  def part_two(input) do
    regex = ~r/(?=(one|1|two|2|three|3|four|4|five|5|six|6|seven|7|eight|8|nine|9))/

    input
    |> Enum.map(&first_last_matching(&1, regex))
    |> Enum.reduce(&+/2)
  end
end
