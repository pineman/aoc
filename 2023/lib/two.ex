defmodule Aoc.Two do
  def run do
    input = Aoc.get_input("two")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end

  # Splitting is admitedly very grug, but probably should've been done using a
  # regex 
  def game(line) do
    [game, sets] = String.split(line, ":")
    game_id = String.split(game) |> List.last() |> String.to_integer()

    sets
    |> String.split(";")
    |> Enum.flat_map(fn set ->
      set
      |> String.trim()
      |> String.split()
      |> Enum.chunk_every(2)
    end)
    |> Enum.group_by(
      fn [_count, cube] -> String.replace(cube, ",", "") end,
      fn [count, _cube] -> String.to_integer(count) end
    )
    |> Map.put("game_id", game_id)
  end

  def part_one(input) do
    input
    |> Enum.map(fn line ->
      map = game(line)

      possible? =
        Enum.max(map["red"]) <= 12 && Enum.max(map["green"]) <= 13 && Enum.max(map["blue"]) <= 14

      if possible?, do: map["game_id"], else: 0
    end)
    |> Enum.reduce(&+/2)
  end

  def part_two(input) do
    input
    |> Enum.map(fn line ->
      map = game(line)
      Enum.max(map["red"]) * Enum.max(map["green"]) * Enum.max(map["blue"])
    end)
    |> Enum.reduce(&+/2)
  end
end
