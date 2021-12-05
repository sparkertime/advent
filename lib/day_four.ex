defmodule DayFour do
  def solve_final_winner(file) do
    [called_numbers_line | board_lines] =
      File.stream!(file)
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))

    called_numbers = parse_called_numbers(called_numbers_line)

    boards =
      board_lines
      |> Enum.chunk_every(5)
      |> Enum.map(&parse_board/1)

    {_, last_winning_board, final_number} =
      called_numbers
      |> Enum.reduce({boards, nil, nil}, fn num, {boards, last_winner, last_winning_number} ->
        boards = Enum.map(boards, &mark_in_board(&1, num))

        case Enum.find(boards, &is_winner?/1) do
          nil ->
            {boards, last_winner, last_winning_number}

          board ->
            {
              Enum.reject(boards, &is_winner?/1),
              board,
              num
            }
        end
      end)

    final_number * sum_board(last_winning_board)
  end

  def solve_winner(file) do
    [called_numbers_line | board_lines] =
      File.stream!(file)
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))

    called_numbers = parse_called_numbers(called_numbers_line)

    boards =
      board_lines
      |> Enum.chunk_every(5)
      |> Enum.map(&parse_board/1)

    {board, final_number} =
      called_numbers
      |> Enum.reduce_while(boards, fn num, boards ->
        boards = Enum.map(boards, &mark_in_board(&1, num))

        case Enum.find(boards, &is_winner?/1) do
          nil -> {:cont, boards}
          board -> {:halt, {board, num}}
        end
      end)

    final_number * sum_board(board)
  end

  defp parse_called_numbers(line) do
    line
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_board(board_lines) do
    board_lines
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @marker -1
  defp mark_in_board(board, number) do
    board
    |> Enum.map(fn line ->
      line
      |> Enum.map(fn x ->
        case x == number do
          true -> @marker
          false -> x
        end
      end)
    end)
  end

  defp is_winner?(board) do
    any_row? =
      Enum.any?(board, fn line ->
        Enum.all?(line, &(&1 == @marker))
      end)

    any_column? =
      Enum.any?(0..4, fn x ->
        Enum.all?(board, fn row ->
          Enum.at(row, x) == @marker
        end)
      end)

    any_row? || any_column?
  end

  defp sum_board(board) do
    Enum.reduce(board, 0, fn line, sum ->
      sum +
        Enum.reduce(line, 0, fn
          @marker, line_sum -> line_sum
          x, line_sum -> line_sum + x
        end)
    end)
  end
end
