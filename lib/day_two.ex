defmodule DayTwo do
  def parse_gold_commands(file) do
    File.stream!(file)
    |> Enum.reduce(%{h: 0, d: 0, a: 0}, fn line, %{h: h, d: d, a: a} ->
      [command, amount] = String.split(line)
      amount = Util.parse(amount)

      case command do
        "forward" ->
          %{h: h + amount, d: d + amount * a, a: a}

        "down" ->
          %{h: h, d: d, a: a + amount}

        "up" ->
          %{h: h, d: d, a: a - amount}
      end
    end)
  end

  def parse_commands(file) do
    File.stream!(file)
    |> Enum.reduce(%{h: 0, d: 0}, fn line, %{h: h, d: d} ->
      [command, amount] = String.split(line)
      amount = Util.parse(amount)

      case command do
        "forward" ->
          %{h: h + amount, d: d}

        "down" ->
          %{h: h, d: d + amount}

        "up" ->
          %{h: h, d: d - amount}
      end
    end)
  end
end
