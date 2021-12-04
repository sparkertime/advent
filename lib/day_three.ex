defmodule DayThree do
  def find_ratings(file) do
    input =
      File.stream!(file)
      |> Enum.map(&String.trim/1)

    {oxygen, _} =
      input
      |> find_rating_in_input(fn zeroes, ones ->
        cond do
          zeroes > ones -> "0"
          true -> "1"
        end
      end)
      |> Integer.parse(2)

    {scrubber, _} =
      input
      |> find_rating_in_input(fn zeroes, ones ->
        cond do
          zeroes > ones -> "1"
          true -> "0"
        end
      end)
      |> Integer.parse(2)

    %{oxygen: oxygen, scrubber: scrubber}
  end

  def find_rating_in_input([{result, _}], _eval_fn), do: result

  def find_rating_in_input([{_original_str, _remainder_str} | _] = input, eval_fn) do
    {zeroes, ones} =
      input
      |> Enum.reduce({0, 0}, fn
        {_, "0" <> _}, {zeroes, ones} -> {zeroes + 1, ones}
        {_, "1" <> _}, {zeroes, ones} -> {zeroes, ones + 1}
      end)

    match_char = eval_fn.(zeroes, ones)

    input
    |> Enum.filter(fn {_original, remainder} ->
      String.at(remainder, 0) == match_char
    end)
    |> Enum.map(fn {original, remainder} ->
      {_, new_remainder} = String.split_at(remainder, 1)
      {original, new_remainder}
    end)
    |> find_rating_in_input(eval_fn)
  end

  def find_rating_in_input(input, eval_fn) do
    input
    |> Enum.map(&{&1, &1})
    |> find_rating_in_input(eval_fn)
  end

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
