defmodule Util do
  def parse(str) do
    str
    |> String.trim()
    |> String.to_integer()
  end
end
