defmodule DayOneTest do
  use ExUnit.Case
  doctest DayOne

  test "parses the example" do
    assert DayOne.increases("./lib/inputs/day_one_example.txt") == 7
  end

  test "it works on the silver test" do
    IO.inspect(DayOne.increases("./lib/inputs/day_one.txt"))
  end

  test "finds summed increases" do
    assert DayOne.summed_increases("./lib/inputs/day_one_example.txt") == 5
  end

  test "it works on the gold test" do
    IO.inspect(DayOne.summed_increases("./lib/inputs/day_one.txt"))
  end
end
