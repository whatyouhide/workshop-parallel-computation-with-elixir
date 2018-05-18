defmodule Lab2.StreamsTest do
  use ExUnit.Case

  @pride_and_prejudice Path.join(__DIR__, "../../pride-and-prejudice.txt")

  @tag :skip
  test "counting words" do
    count = Lab2.Streams.count_words_until_stop_word(@pride_and_prejudice, "amusement")

    assert count["must"] == 7
    assert count["twenty"] == 3
    assert count["end"] == 1

    refute Map.has_key?(count, "amusement")
  end

  @tag :skip
  test "take_while/2" do
    stream = Lab2.Streams.take_while(1..1000, &(&1 <= 5))
    assert Enum.to_list(stream) == [1, 2, 3, 4, 5]

    assert Enum.to_list(Lab2.Streams.take_while(1..1000, &(&1 <= 0))) == []
    assert Enum.to_list(Lab2.Streams.take_while(1..3, &(&1 <= 5))) == [1, 2, 3]

    nats = Stream.iterate(1, &(&1 + 1))
    assert Enum.to_list(Lab2.Streams.take_while(nats, &(&1 <= 5))) == [1, 2, 3, 4, 5]

    stream = Stream.drop(1..100, 5)
    assert Lab2.Streams.take_while(stream, &(&1 < 11)) |> Enum.to_list() == [6, 7, 8, 9, 10]
  end

  @tag :skip
  test "uniq/1" do
    assert Lab2.Streams.uniq([1, 2, 3, 2, 1]) |> Enum.to_list() == [1, 2, 3]
  end

  @tag :skip
  test "dedup/1" do
    assert Lab2.Streams.dedup([1, 1, 2, 1, 1, 2, 1]) |> Enum.to_list() == [1, 2, 1, 2, 1]
    assert Lab2.Streams.dedup([2, 1, 1, 2, 1]) |> Enum.to_list() == [2, 1, 2, 1]
    assert Lab2.Streams.dedup([1, 2, 3, 4]) |> Enum.to_list() == [1, 2, 3, 4]
    assert Lab2.Streams.dedup([1, 1.0, 2.0, 2]) |> Enum.to_list() == [1, 1.0, 2.0, 2]
    assert Lab2.Streams.dedup([]) |> Enum.to_list() == []

    assert Lab2.Streams.dedup([nil, nil, true, {:value, true}]) |> Enum.to_list() ==
             [nil, true, {:value, true}]

    assert Lab2.Streams.dedup([nil]) |> Enum.to_list() == [nil]
  end
end

defmodule Lab2.TasksTest do
  use ExUnit.Case

  @tag :skip
  test "pmap/2" do
    {time_in_microsec, result} =
      :timer.tc(fn ->
        Lab2.Tasks.pmap([1000, 1000, 1000], fn ms ->
          Process.sleep(ms)
          Integer.to_string(ms)
        end)
      end)

    assert div(time_in_microsec, 1000) in 1000..2000
    assert result == ["1000", "1000", "1000"]
  end

  describe "async/await" do
    @tag :skip
    test "when everything goes fine" do
      async = Lab2.Tasks.async(fn -> 1 + 10 end)
      assert Lab2.Tasks.await(async) == {:ok, 11}
    end

    @tag :skip
    @tag :capture_log
    test "when the process crashes" do
      async = Lab2.Tasks.async(fn -> raise "nope!" end)
      assert Lab2.Tasks.await(async) == :error
    end

    @tag :skip
    test "no messages are leaked" do
      async = Lab2.Tasks.async(fn -> 1 + 10 end)
      assert Lab2.Tasks.await(async) == {:ok, 11}
      refute_receive _
    end
  end
end
