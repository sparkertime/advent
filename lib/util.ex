defmodule Util do
  def parse(str) do
    str
    |> String.trim()
    |> String.to_integer()
  end

  def load_file(file) do
    file
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end
end
