defmodule ReportsGenerator do
  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @available_keys ["users", "foods"]

  def build(filename) do
    file =
      filename
      |> ReportsGenerator.Parser.call()
      |> Enum.reduce(create_initial_report_acc(), fn line, acc -> sum_values(line, acc) end)
  end

  def sum_values(
        [id, food, value] = line,
        %{"foods" => foods, "users" => users} = report
      ) do
    updated_users = Map.put(users, id, users[id] + value)
    updated_foods = Map.put(foods, food, foods[food] + 1)

    # Uma das formas de devolver uma mapa atualizado
    # report
    # |> Map.put("users", updated_users)
    # |> Map.put("foods", updated_foods)

    # Segunda forma de atualizar e deolver o mapa
    %{report | "users" => updated_users, "foods" => updated_foods}
  end

  # when são guards, ampliam a aplicação do pattern matching, neste caso, a função abaixo só sera executada se a key recebida como parametro, existir em @available_keys
  def fetch_higher(report, key) when key in @available_keys,
    # Usando função max_by do modulo Enum para buscar o maior valor de um coleção
    do: {:ok, Enum.max_by(report[key], fn {_key, value} -> value end)}

  def fetch_higher(_report, _key), do: {:error, "Invalid key"}

  defp create_initial_report_acc do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    %{"users" => users, "foods" => foods}
  end

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
