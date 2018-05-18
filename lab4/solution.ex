defmodule Lab4 do
  def sum_enumerable(enum) do
    enum
    |> Enum.chunk_every(1000)
    |> Flow.from_enumerables()
    |> Flow.reduce(fn -> 0 end, &+/2)
    |> Flow.emit(:state)
    |> Enum.sum()
  end

  def most_frequent_words(file_path, num) do
    file_path
    |> File.stream!()
    |> Flow.from_enumerable()
    |> Flow.map(&String.trim/1)
    |> Flow.flat_map(&String.split(&1, " ", trim: true))
    |> Flow.map(&normalize_string/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, acc ->
      Map.update(acc, word, 1, & &1 + 1)
    end)
    |> Flow.map(fn {word, count} -> {count, word} end)
    |> Enum.sort(&>=/2)
    |> Enum.take(num)
    |> Enum.map(fn {_count, word} -> word end)
  end

  defp normalize_string(string) do
    string
    |> String.downcase()
    |> String.replace(~w(, ? . ! ; _ “ ”), "")
  end
end
