defmodule DayFourTest do
  use ExUnit.Case
  doctest DayFour

  test "solves the silver example" do
    assert 4512 == DayFour.solve_winner("./inputs/day_four_example.txt")
  end

  test "solves the silver challenge" do
    IO.inspect(DayFour.solve_winner("./inputs/day_four.txt"))
  end

  test "solves the gold example" do
    assert 1924 == DayFour.solve_final_winner("./inputs/day_four_example.txt")
  end

  test "solves the gold challenge" do
    IO.inspect(DayFour.solve_final_winner("./inputs/day_four.txt"))
  end
end
