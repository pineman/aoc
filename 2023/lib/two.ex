defmodule Aoc.Two do
  def run do
    input = Aoc.get_input("two")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end

  def part_one(input) do
    input
    |> Enum.map(fn line ->
      [game, rest] = String.split(line, ":")
      game_id = String.split(game) |> List.last() |> String.to_integer()

      possible? =
        rest
        |> String.split(";")
        |> Enum.flat_map(fn run ->
          run
          |> String.trim()
          |> String.split()
          |> Enum.chunk_every(2)
          |> Enum.map(fn [count, cube] ->
            count = String.to_integer(count)
            cube = String.replace(cube, ",", "")

            (cube == "red" && count <= 12) || (cube == "green" && count <= 13) ||
              (cube == "blue" && count <= 14)
          end)
        end)
        |> Enum.all?(&(&1 == true))

      if possible?, do: game_id, else: 0
    end)
    |> Enum.reduce(&+/2)
  end

  def part_two(input) do
    input
    |> Enum.map(fn line ->
      line
      |> String.split(":")
      |> List.last()
      |> String.split(";")
      |> Enum.flat_map(fn run ->
        run
        |> String.trim()
        |> String.split()
        |> Enum.chunk_every(2)
      end)
      |> Enum.group_by(
        fn [_count, cube] ->
          String.replace(cube, ",", "")
        end,
        fn [count, _cube] ->
          String.to_integer(count)
        end
      )
      |> Enum.map(fn {color, counts} ->
        Enum.max(counts)
      end)
      |> Enum.reduce(&*/2)
    end)
    |> Enum.reduce(&+/2)
  end
end
