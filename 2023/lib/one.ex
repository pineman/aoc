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
    line
    |> String.replace("one", "one1one")
    |> String.replace("two", "two2two")
    |> String.replace("three", "three3three")
    |> String.replace("four", "four4fourk")
    |> String.replace("five", "five5five")
    |> String.replace("six", "six6six")
    |> String.replace("seven", "seven7seven")
    |> String.replace("eight", "eight8eight")
    |> String.replace("nine", "nine9nine")
  end

  def part_two(input) do
    input
    |> Enum.map(&translate/1)
    |> part_one()
  end
end
