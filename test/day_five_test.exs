defmodule DayFiveTest do
  use ExUnit.Case
  doctest DayFive

  test "solves the silver example" do
    assert 5 == DayFive.solve_silver("./inputs/day_five_example.txt")
  end

  test "solves the silver challenge" do
    IO.inspect(DayFive.solve_silver("./inputs/day_five.txt"))
  end

  test "solves the gold example" do
    assert 12 == DayFive.solve_gold("./inputs/day_five_example.txt")
  end

  test "solves the gold challenge" do
    IO.inspect(DayFive.solve_gold("./inputs/day_five.txt"))
  end
end
