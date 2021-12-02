defmodule DayOne do
  def increases(file) do
    inputs =
      File.stream!(file)
      |> Enum.map(&Util.parse/1)

    find_increases(inputs, 0)
  end

  defp find_increases([x | rest], current_increases) do
    prior_increases = find_increases(rest, current_increases)

    case rest do
      [y | _] when y > x ->
        prior_increases + 1

      _ ->
        prior_increases
    end
  end

  defp find_increases([], current_increases), do: current_increases

  def summed_increases(file) do
    inputs =
      File.stream!(file)
      |> Enum.map(&Util.parse/1)

    find_summed_increases(inputs, 0)
  end

  defp find_summed_increases([a | rest], current_increases) do
    prior_increases = find_summed_increases(rest, current_increases)

    case rest do
      [b, c, d | _] ->
        first_set = a + b + c
        second_set = b + c + d

        if(second_set > first_set) do
          prior_increases + 1
        else
          prior_increases
        end

      _ ->
        prior_increases
    end
  end

  defp find_summed_increases(_, current_increases), do: current_increases
end
