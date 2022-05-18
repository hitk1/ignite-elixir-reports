defmodule ReportsGenerator do
  def build(filename) do
    # Lendo o arquivo com case (switch case)

    # case File.read!("reports/#{filename}") do
    #   {:ok, file} -> file
    #   {:error, _reason} -> "Error while opening file!"
    # end

    # Com pipe operator e pattern matching
    file =
      "reports/#{filename}"
      |> File.read()
      |> handle_file()
  end

  defp handle_file({:ok, content}), do: content
  defp handle_file({:error, _reason}), do: "Error while opening file!"
end
