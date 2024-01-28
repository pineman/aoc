defmodule Aoc do
  @moduledoc """
  When `use`d, defines a `run` function that automatically gets a day's input
  by the last part of the module name. For example, for the module Aoc.Two,
  it reads the file `input/two`. Just because I can :)
  """

  defmacro __using__(_opts) do
    module =
      Atom.to_string(__CALLER__.module) |> String.split(".") |> List.last() |> String.downcase()

    quote do
      def run do
        input = Aoc.get_input(unquote(module))
        IO.puts(part_one(input))
        IO.puts(part_two(input))
      end
    end
  end

  # File.read/1 vs File.read!/1 https://elixir-lang.org/getting-started/try-catch-and-rescue.html#errors
  def get_input(day) do
    File.read!("input/#{day}")
    |> String.split("\n")
    |> Enum.drop(-1)
  end
end
