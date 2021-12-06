defmodule DaySixTest do
  use ExUnit.Case
  doctest DaySix

  @moduletag timeout: :infinity

  test "solves the silver example" do
    assert 5934 == DaySix.solve_silver("./inputs/day_six_example.txt")
  end

  test "solves the silver challenge" do
    IO.inspect(DaySix.solve_silver("./inputs/day_six.txt"))
  end

  test "solves the gold example" do
    assert 26_984_457_539 == DaySix.solve_gold("./inputs/day_six_example.txt")
  end

  test "solves the gold challenge" do
    IO.inspect(DaySix.solve_gold("./inputs/day_six.txt"))
  end
end
