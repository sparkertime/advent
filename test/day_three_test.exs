defmodule DayThreeTest do
  use ExUnit.Case
  doctest DayThree

  test "solves the example" do
    assert %{gamma: 22, epsilon: 9} = DayThree.find_rates("./inputs/day_three_example.txt")
  end

  test "it works on the silver test" do
    x = DayThree.find_rates("./inputs/day_three.txt")
    IO.puts(x.epsilon * x.gamma)
  end

  test "solves the gold example" do
    assert %{oxygen: 23, scrubber: 10} = DayThree.find_ratings("./inputs/day_three_example.txt")
  end

  test "calculated the gold answer" do
    x = DayThree.find_ratings("./inputs/day_three.txt")

    IO.puts(x.oxygen * x.scrubber)
  end
end
