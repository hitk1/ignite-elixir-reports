defmodule ReportsGeneratorTest do
  use ExUnit.Case
  doctest ReportsGenerator

  describe "build/1" do
    test "build the report" do
      file_name = "report_test.csv"

      response = ReportsGenerator.build(file_name)

      expected_response = %{
        "foods" => %{
          "a├ºa├¡" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hamb├║rguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert is_map(response) == is_map(expected_response)
    end
  end

  describe "fetch_higher/2" do
    test "when the opetions is 'users' returns the user who spent the most" do
      file_name = "report_test.csv"

      {status_result, data} =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher("users")

      expected_response = :ok

      assert status_result == expected_response
    end

    test "when the opetions is 'foods' returns the most consumed food" do
      file_name = "report_test.csv"

      {status_result, data} =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher("foods")

      expected_response = :ok

      assert status_result == expected_response
    end

    test "when an invalid option is given, returns an error" do
      file_name = "report_test.csv"

      {status_result, data} =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher("testing")

      expected_response = :error

      assert status_result == expected_response
    end
  end
end
