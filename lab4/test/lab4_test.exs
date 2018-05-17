defmodule Lab4Test do
  use ExUnit.Case

  @pride_and_prejudice Path.join(__DIR__, "../../pride-and-prejudice.txt")

  @tag :skip
  test "task 1: sum enumerable" do
    assert Lab4.sum_enumerable(1..10) == Enum.sum(1..10)
    assert Lab4.sum_enumerable(1..1000) == Enum.sum(1..1000)
    assert Lab4.sum_enumerable(1..100000) == Enum.sum(1..100000)
  end

  @tag :skip
  test "task 2: most frequent words" do
    words = Lab4.most_frequent_words(@pride_and_prejudice, 3)
    assert words == ["the", "to", "of"]

    words = Lab4.most_frequent_words(@pride_and_prejudice, 10)
    assert words == ["the", "to", "of", "and", "her", "i", "a", "in", "was", "she"]
  end
end
