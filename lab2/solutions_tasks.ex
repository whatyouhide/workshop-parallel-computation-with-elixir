defmodule Lab2.Tasks do
  @doc """
  Maps the given `fun` in parallel over all elements of `enum`.

  The end result of this function should be the same as `Enum.map/2`, except that
  each element is processed in parallel with all the others.

  ## Examples

      pmap([url1, url2, ...], fn url -> expensive_request(url) end)
      #=> [response1, response2, ...]

  """
  @spec pmap(Enumerable.t(), (a -> b)) :: Enumerable.t() when a: term(), b: term()
  def pmap(enum, fun) when is_function(fun, 1) do
    enum
    |> Enum.map(&Task.async(fn -> fun.(&1) end))
    |> Enum.map(&Task.await/1)
  end

  @doc """
  Spawns a process that executes the given computation (given as a function) and that can be
  awaited on.

  Suggestion: there's a function in the `Kernel` module that can help avoiding a race condition
  when spawning *and then* monitoring.

  ## Examples

  See the `await/1` function.
  """
  @spec async((() -> term())) :: term()
  def async(fun) when is_function(fun, 0) do
    parent = self()
    ref = make_ref()

    {_pid, monitor_ref} =
      spawn_monitor(fn ->
        result = fun.()
        send(parent, {ref, result})
      end)

    {ref, monitor_ref}
  end

  @doc """
  Awaits on the result of a computation started with `async/1` and returns `{:ok, result}` if
  the result was computed or `:error` if the process crashed.

  Note that if you have

      ref = Process.monitor(pid)

  then if `pid` dies for some reason a message will be delivered to the monitoring process. The
  message would have the following shape:

      {:DOWN, ref, _, _, _}

  ## Examples

      iex> async = Monitor.async(fn -> 1 + 10 end)
      iex> Monitor.await(async)
      {:ok, 11}

  """
  @spec await(term()) :: term()
  def await({ref, monitor_ref} = _task) do
    receive do
      {^ref, result} ->
        Process.demonitor(monitor_ref, [:flush])
        {:ok, result}

      {:DOWN, ^monitor_ref, _, _, _} ->
        :error
    end
  end

  @doc """
  Takes a stream of enumerables and returns a stream of the sum of each enumerable.

  ## Examples

      iex> Enum.to_list(sum_all([1..2, 3..4, 5..6]))
      [3, 7, 11]

  """
  @spec sum_all(Enumerable.t()) :: Enumerable.t()
  def sum_all(stream_of_enums) do
    stream_of_enums
    |> Task.async_stream(&Enum.sum/1)
    |> Stream.map(fn {:ok, i} -> i end)
  end
end
