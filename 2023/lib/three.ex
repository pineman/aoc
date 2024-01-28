defmodule Aoc.Three do
  use Aoc

  def part_numbers(line, prev_line, next_line) do
    Regex.scan(~r/\d+/, line, return: :index)
    |> Enum.map(fn [{i, len}] ->
      window_start = if i == 0, do: i, else: i - 1
      window_len = if i == 0, do: len + 1, else: len + 2
      p = String.slice(prev_line, window_start, window_len)
      l = String.slice(line, window_start, window_len)
      n = String.slice(next_line, window_start, window_len)

      if any_symbol?(p) or any_symbol?(l) or any_symbol?(n) do
        line |> String.slice(i, len) |> String.to_integer()
      end
    end)
    |> Enum.reject(&(&1 == nil))
  end

  def any_symbol?(s) do
    String.match?(s, ~r/\#|\$|\%|\&|\*|\+|\-|\/|\=|\@/)
  end

  def part_one(input) do
    ([""] ++ input ++ [""])
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn [prev_line, line, next_line] ->
      part_numbers(line, prev_line, next_line)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  def gears(line, prev_line, next_line) do
    Regex.scan(~r/\*/, line, return: :index)
    |> Enum.map(fn [{i, _len}] ->
      window_start = if i == 0, do: i, else: i - 1
      window_len = if i == 0 or i == String.length(line) - 1, do: 2, else: 3

      gears =
        [prev_line, line, next_line]
        |> Enum.flat_map(&gears_in_line(&1, window_start, window_len))

      if Enum.count(gears) == 2 do
        Enum.reduce(gears, &*/2)
      else
        0
      end
    end)
  end

  def gears_in_line(line, window_start, window_len) do
    sub = String.slice(line, window_start, window_len)
    gear_count = count_gears(sub)

    if gear_count > 0 do
      l = left(line, window_start)
      r = right(line, window_start + window_len - 1)
      sub = String.slice(line, l..r)

      if gear_count == 1 do
        [Regex.scan(~r/\d+/, sub) |> List.first() |> List.first() |> String.to_integer()]
      else
        String.split(sub, ~r/\#|\$|\%|\&|\*|\+|\-|\/|\=|\@|\./) |> Enum.map(&String.to_integer/1)
      end
    else
      []
    end
  end

  def left(line, l) do
    cond do
      not String.match?(String.at(line, l), ~r/\d/) -> l
      l - 1 < 0 -> l
      String.match?(String.at(line, l - 1), ~r/\d/) -> left(line, l - 1)
      true -> l
    end
  end

  def right(line, r) do
    cond do
      not String.match?(String.at(line, r), ~r/\d/) -> r
      r + 1 >= String.length(line) -> r
      String.match?(String.at(line, r + 1), ~r/\d/) -> right(line, r + 1)
      true -> r
    end
  end

  def count_gears(line) do
    if String.match?(line, ~r/\d/) do
      if String.match?(line, ~r/\d(\#|\$|\%|\&|\*|\+|\-|\/|\=|\@|\.)\d/) do
        2
      else
        1
      end
    else
      0
    end
  end

  def part_two(input) do
    ([""] ++ input ++ [""])
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn [prev_line, line, next_line] ->
      gears(line, prev_line, next_line)
    end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end
end
