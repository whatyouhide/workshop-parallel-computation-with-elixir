defmodule Lab2.Streams do
  @doc """
  Counts the words in the given file until the first line that contains "stop word".

  This function should take all the lines of the given file until the first one that contains
  `stop_word` and count the occurrences of each word only on these lines. The lines should be
  normalized (by calliing `normalize_string/1`) before counting the words.

  The result should be a map like `%{word => count}` with words as keys and number of occurrences
  as values.

  ## Example

  Considering a file with these contents:

      # my_file.txt
      Hello world!
      Everything good world?
      Awesome, see you later.

  then this function should behave like follows:

      count_words_until_amusement("my_file.txt", "awesome")
      #=> %{"hello" => 1, "world" => 2, "everything" => 1, "good" => 1}

  """
  @spec count_words_until_stop_word(Path.t(), String.t()) :: %{String.t() => pos_integer()}
  def count_words_until_stop_word(file_path, stop_word) do
    file_path
    |> File.stream!()
    |> Stream.map(&normalize_string/1)
    |> Stream.take_while(&not(String.contains?(&1, stop_word)))
    |> Stream.flat_map(&String.split/1)
    |> Enum.group_by(& &1)
    |> Map.new(fn {word, words} -> {word, length(words)} end)
  end

  defp normalize_string(string) do
    string
    |> String.downcase()
    |> String.replace(~w(, ? . ! ; _ “ ”), "")
  end

  @doc """
  Takes elements from the given `enum` while `predicate` returns true for those elements.

  As soon as `predicate` returns false for a given element, the enumeration stops.

  ## Examples

      stream = take_while([1, 2, 3, 4, 5], fn elem -> elem < 4 end)
      Enum.to_list(stream)
      #=> [1, 2, 3]

  """
  @spec take_while(Enumerable.t(), (term() -> boolean())) :: Enumerable.t()
  def take_while(enum, predicate) do
    Stream.transform(enum, nil, fn elem, nil ->
      if predicate.(elem) do
        {[elem], nil}
      else
        {:halt, nil}
      end
    end)
  end

  @doc """
  Takes an enumerable and returns that enumerable but without consecutive duplicate elements.

  ## Examples

      stream = dedup([1, 2, 1, 1, 5, 8, 8, 8, 1])
      Enum.to_list(stream)
      #=> [1, 2, 1, 5, 8, 1]

  """
  @spec dedup(Enumerable.t()) :: Enumerable.t()
  def dedup(enum) do
    Stream.transform(enum, :none, fn
      elem, :none -> {[elem], {:previous, elem}}
      elem, {:previous, elem} -> {[], {:previous, elem}}
      elem, _ -> {[elem], {:previous, elem}}
    end)
  end

  @doc """
  Takes an enumerable and returns that enumerable but without duplicate elements.

  ## Examples

      stream = dedup([1, 2, 1, 1, 5, 8, 8, 8, 1])
      Enum.to_list(stream)
      #=> [1, 2, 5, 8]

  """
  @spec uniq(Enumerable.t()) :: Enumerable.t()
  def uniq(enum) do
    Stream.transform(enum, MapSet.new(), fn elem, seen ->
      if elem in seen do
        {[], seen}
      else
        {[elem], MapSet.put(seen, elem)}
      end
    end)
  end
end
