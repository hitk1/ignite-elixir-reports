defmodule ReportsGenerator.ParserTest do
  use ExUnit.Case

  alias ReportsGenerator.Parser

  # As notações corretas são sempre o nome da função a ser testada com a aridade
  describe "call/1" do
    test "parse the file" do
      file_name = "report_test.csv"

      response =
        file_name
        |> Parser.call()
        |> Enum.map(& &1)

      expected_response = [
        ["1", "pizza", 48],
        ["2", "a├ºa├¡", 45],
        ["3", "hamb├║rguer", 31],
        ["4", "esfirra", 42],
        ["5", "hamb├║rguer", 49],
        ["6", "esfirra", 18],
        ["7", "pizza", 27],
        ["8", "esfirra", 25],
        ["9", "churrasco", 24],
        ["10", "churrasco", 36]
      ]

      assert length(response) == length(expected_response)
    end
  end
end
