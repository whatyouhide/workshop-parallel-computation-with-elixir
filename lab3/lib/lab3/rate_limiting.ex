defmodule Lab3.RateLimitedConsumer do
  use GenStage

  @interval 1000

  def init(_) do
    {:consumer, _producers = %{}}
  end

  def handle_subscribe(:producer, opts, from, producers) do
    # We will only allow max_demand events every 5000 milliseconds
    pending = opts[:max_demand] || 1000

    # Register the producer in the state
    producers = Map.put(producers, from, pending)
    # Ask for the pending events and schedule the next time around
    producers = ask_and_schedule(producers, from)

    # Returns manual as we want control over the demand
    {:manual, producers}
  end

  def handle_cancel(_, from, producers) do
    # Remove the producers from the map on unsubscribe
    {:noreply, [], Map.delete(producers, from)}
  end

  def handle_events(events, from, producers) do
    # TODO: Bump the amount of pending events for the given producer.
    # ...

    # Consume the events.
    Enum.each(events, &process_event/1)

    # A producer_consumer would return the processed events here.
    {:noreply, [], producers}
  end

  def handle_info({:ask, from}, producers) do
    # This callback is invoked by the Process.send_after/3 message below.
    {:noreply, [], ask_and_schedule(producers, from)}
  end

  # Should ask the producer ("from") for mode demand with GenStage.ask/2, and schedule the next
  # time it should ask.
  defp ask_and_schedule(producers, from) do
    raise "not implemented yet"
  end

  defp process_event(event) do
    IO.inspect(event)
  end
end
