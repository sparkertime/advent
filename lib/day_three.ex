defmodule DayThree do
  def find_rates(file) do
    input = File.stream!(file)

    results =
      input
      |> Enum.at(0)
      |> String.trim()
      |> String.split("", trim: true)
      |> Enum.map(fn _ -> %{ones: 0, zeroes: 0} end)

    digit_counts =
      Enum.reduce(input, results, fn str, results ->
        str
        |> String.trim()
        |> String.split("", trim: true)
        |> Enum.with_index()
        |> Enum.reduce(results, fn {c, i}, results ->
          %{ones: a, zeroes: b} = Enum.at(results, i)

          List.replace_at(
            results,
            i,
            case c do
              "0" -> %{ones: a, zeroes: b + 1}
              "1" -> %{ones: a + 1, zeroes: b}
            end
          )
        end)
      end)

    {epsilon, _} =
      digit_counts
      |> Enum.reduce("", fn %{ones: a, zeroes: b}, str ->
        cond do
          a > b -> str <> "0"
          a < b -> str <> "1"
          true -> raise "uh oh"
        end
      end)
      |> Integer.parse(2)

    {gamma, _} =
      digit_counts
      |> Enum.reduce("", fn %{ones: a, zeroes: b}, str ->
        cond do
          a > b -> str <> "1"
          a < b -> str <> "0"
          true -> raise "uh oh"
        end
      end)
      |> Integer.parse(2)

    %{gamma: gamma, epsilon: epsilon}
  end
end
