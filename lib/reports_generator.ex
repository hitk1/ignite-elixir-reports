defmodule ReportsGenerator do
  def build(filename) do
    file =
      filename
      |> ReportsGenerator.Parser.call()
      |> Enum.reduce(create_initial_report_acc, fn [id, _food, value], acc ->
        Map.put(acc, id, acc[id] + value)
      end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    # Notação de função anonima implicita, &String.to_integer é a mesma coisa que: fn item -> String.to_integer(item)
    |> List.update_at(2, &String.to_integer/1)
  end

  defp create_initial_report_acc, do: Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

  # def build(filename) do
  #   # Lendo o arquivo com case (switch case)

  #   # case File.read!("reports/#{filename}") do
  #   #   {:ok, file} -> file
  #   #   {:error, _reason} -> "Error while opening file!"
  #   # end

  #   # Com pipe operator e pattern matching
  #   file =
  #     "reports/#{filename}"
  #     |> File.read()
  #     |> handle_file()
  # end

  # defp handle_file({:ok, content}), do: content
  defp handle_file({:error, _reason}), do: "Error while opening file!"
end
