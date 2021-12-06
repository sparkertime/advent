defmodule DaySix do
  def solve_silver(file) do
    starting_fish =
      Util.load_file(file)
      |> parse_fish()

    Enum.reduce(0..79, starting_fish, fn _, fish ->
      Enum.reduce(fish, [], fn fish_timer, new_fish ->
        case fish_timer do
          0 -> [6, 8 | new_fish]
          x -> [x - 1 | new_fish]
        end
      end)
    end)
    |> Enum.count()
  end

  def solve_gold(file) do
    starting_fish_map =
      Util.load_file(file)
      |> parse_fish()
      |> to_fish_map()

    Enum.reduce(0..255, starting_fish_map, fn _, fish_map ->
      %{
        0 => fish_map[1],
        1 => fish_map[2],
        2 => fish_map[3],
        3 => fish_map[4],
        4 => fish_map[5],
        5 => fish_map[6],
        6 => fish_map[7] + fish_map[0],
        7 => fish_map[8],
        8 => fish_map[0]
      }
    end)
    |> Enum.reduce(0, fn {_k, v}, sum ->
      sum + v
    end)
  end

  def parse_fish([str]) do
    String.split(str, ",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def to_fish_map(fish_timers) do
    new_fish_map =
      Enum.map(0..8, fn i -> {i, 0} end)
      |> Enum.into(%{})

    Enum.reduce(fish_timers, new_fish_map, fn timer, map ->
      Map.update(map, timer, 0, &(&1 + 1))
    end)
  end
end
