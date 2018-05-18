defmodule Lab4 do
  def sum_enumerable(_enum) do
    raise "not implenented yet"
  end

  def most_frequent_words(_file_path, _num) do
    raise "not implenented yet"
  end

  defp normalize_string(string) do
    string
    |> String.downcase()
    |> String.replace(~w(, ? . ! ; _ “ ”), "")
  end
end
