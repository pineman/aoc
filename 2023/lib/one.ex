defmodule Aoc.One do
  def run do
    input = Aoc.get_input("one")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end

  def part_one(input) do
    input
    |> Enum.map(fn line ->
      numbers = String.replace(line, ~r/[a-z]/, "")
      a = numbers |> String.first() |> String.to_integer()
      b = numbers |> String.last() |> String.to_integer()
      a * 10 + b
    end)
    |> Enum.reduce(&+/2)
  end

  def translate(line) do
    list =
      [
        [~r/one|1/, "1"],
        [~r/two|2/, "2"],
        [~r/three|3/, "3"],
        [~r/four|4/, "4"],
        [~r/five|5/, "5"],
        [~r/six|6/, "6"],
        [~r/seven|7/, "7"],
        [~r/eight|8/, "8"],
        [~r/nine|9/, "9"]
      ]
      |> Enum.flat_map(fn [regex, number] ->
        regex
        |> Regex.scan(line, return: :index)
        |> Enum.map(fn [{index, _size}] ->
          %{number: number, index: index}
        end)
      end)
      |> Enum.sort_by(fn %{index: index, number: _number} ->
        index
      end)

    a = List.first(list) |> Map.get(:number) |> String.to_integer()
    b = List.last(list) |> Map.get(:number) |> String.to_integer()
    a * 10 + b
  end

  def part_two(input) do
    input
    |> Enum.map(&translate/1)
    |> Enum.reduce(&+/2)
  end
end
