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
      IO.puts("#{line}: #{a * 10 + b}")
      a * 10 + b
    end)
    |> Enum.reduce(&+/2)
  end

  def translate(line) do
    nums_indices =
      [
        [~r/one/, "1"],
        [~r/two/, "2"],
        [~r/three/, "3"],
        [~r/four/, "4"],
        [~r/five/, "5"],
        [~r/six/, "6"],
        [~r/seven/, "7"],
        [~r/eight/, "8"],
        [~r/nine/, "9"]
      ]
      |> Enum.map(fn [regex, number] ->
        case Regex.run(regex, line, return: :index) do
          [{index, _b}] -> %{index: index, regex: regex, number: number}
          nil -> nil
        end
      end)
      |> Enum.reject(&is_nil/1)

    try do
      %{regex: regex, number: number} =
        Enum.min_by(nums_indices, &Map.get(&1, :index))

      line
      |> String.replace(regex, number)
      |> translate()
    rescue
      _ in Enum.EmptyError -> line
    end
  end

  def part_two(input) do
    input
    |> Enum.map(&translate/1)
    |> part_one()
  end
end
