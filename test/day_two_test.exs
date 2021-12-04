defmodule DayTwoTest do
  use ExUnit.Case
  doctest DayTwo

  test "parses inputs" do
    assert DayTwo.parse_commands("./inputs/day_two_example.txt") == %{h: 15, d: 10}
  end

  test "it solves the problems" do
    x = DayTwo.parse_commands("./inputs/day_two.txt")
    IO.puts(x.d * x.h)
  end

  test "parses gold inputs" do
    assert %{h: 15, d: 60} = DayTwo.parse_gold_commands("./inputs/day_two_example.txt")
  end

  test "it solves the gold problems" do
    x = DayTwo.parse_gold_commands("./inputs/day_two.txt")

    IO.puts(x.d * x.h)
  end
end
