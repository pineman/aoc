defmodule Aoc.Four do
  use Aoc

  def count_matching(line) do
    [win, have] =
      line
      |> String.split(":")
      |> List.last()
      |> String.split("|")
      |> Enum.map(fn nums ->
        nums |> String.split() |> Enum.map(&String.to_integer/1) |> MapSet.new()
      end)

    MapSet.intersection(win, have) |> Enum.count()
  end

  def part_one(input) do
    input
    |> Enum.map(fn line ->
      count = count_matching(line)
      trunc(2 ** (count - 1))
    end)
    |> Enum.sum()
  end

  def part_two(input) do
    num_lines = length(input)
    times = Enum.to_list(1..num_lines) |> Enum.map(fn _ -> 1 end)

    input
    |> Enum.with_index()
    |> Enum.reduce(times, fn {line, i}, times ->
      # Stop at the penultimate card
      if i < num_lines - 2 do
        count = count_matching(line)

        won =
          if count == 0 do
            []
          else
            Enum.to_list((i + 1)..min(i + count, num_lines - 1))
          end

        won
        |> Enum.reduce(times, fn j, times ->
          List.replace_at(times, j, Enum.at(times, j) + Enum.at(times, i))
        end)
      else
        times
      end
    end)
    |> Enum.sum()
  end
end
