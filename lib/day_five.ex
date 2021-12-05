defmodule DayFive do
  def solve_gold(file) do
    lines =
      Util.load_file(file)
      |> Enum.map(&to_coordinates/1)

    map = empty_map_from_lines(lines)

    lines
    |> Enum.reduce(map, &mark_line/2)
    |> count_intersections()
  end

  def solve_silver(file) do
    lines =
      Util.load_file(file)
      |> Enum.map(&to_coordinates/1)
      |> Enum.reject(fn [[x1, y1], [x2, y2]] -> x1 != x2 && y1 != y2 end)

    map = empty_map_from_lines(lines)

    lines
    |> Enum.reduce(map, &mark_line/2)
    |> count_intersections()
  end

  defp to_coordinates(str) do
    str
    |> String.split(" -> ")
    |> Enum.map(fn coord_str ->
      coord_str
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp empty_map_from_lines(lines) do
    max =
      Enum.reduce(lines, 0, fn [[x1, y1], [x2, y2]], max ->
        Enum.max([x1, x2, y1, y2, max])
      end)

    Enum.map(0..max, fn _ ->
      Enum.map(0..max, fn _ -> 0 end)
    end)
  end

  defp mark_line([[x, y1], [x, y2]], map) do
    min_y = min(y1, y2)
    max_y = max(y1, y2)

    Enum.with_index(map)
    |> Enum.map(fn {row, i} ->
      case i >= min_y && i <= max_y do
        true ->
          List.update_at(row, x, &(&1 + 1))

        false ->
          row
      end
    end)
  end

  defp mark_line([[x1, y], [x2, y]], map) do
    min_x = min(x1, x2)
    max_x = max(x1, x2)

    List.update_at(
      map,
      y,
      fn row ->
        Enum.with_index(row)
        |> Enum.map(fn {val, i} ->
          case i >= min_x && i <= max_x do
            true ->
              val + 1

            false ->
              val
          end
        end)
      end
    )
  end

  defp mark_line([[x1, y1], [x2, y2]], map) do
    Enum.zip(x1..x2, y1..y2)
    |> Enum.reduce(map, fn {x, y}, map ->
      List.update_at(map, y, fn row ->
        List.update_at(row, x, &(&1 + 1))
      end)
    end)
  end

  defp count_intersections(map) do
    Enum.reduce(map, 0, fn line, total ->
      Enum.reduce(line, total, fn i, line_total ->
        case i > 1 do
          true -> line_total + 1
          false -> line_total
        end
      end)
    end)
  end
end
