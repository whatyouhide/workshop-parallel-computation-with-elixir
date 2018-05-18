defmodule Lab3.PartitionDispatcherTest do
  use ExUnit.Case

  defmodule InvoiceConsumer do
    use GenStage

    import ExUnit.Assertions

    def start_link(region) do
      GenStage.start_link(__MODULE__, region)
    end

    def init(region) do
      producer = {Lab3.InvoiceProducer, partition: region, max_demand: 10, min_demand: 5}
      {:consumer, region, subscribe_to: [producer]}
    end

    def handle_events(events, _from, region) do
      Enum.each(events, fn event ->
        assert event.region == region
      end)

      {:noreply, [], region}
    end
  end

  @tag :skip
  test "partition dispatcher" do
    regions = [:us, :eu, :asia]

    assert {:ok, _} = Lab3.InvoiceProducer.start_link(regions)

    for region <- regions do
      assert {:ok, _} = InvoiceConsumer.start_link(region)
    end

    Process.sleep(2000)
  end
end

defmodule Lab3.RateLimitedConsumerTest do
  use ExUnit.Case

  defmodule Producer do
    use GenStage

    @interval 1000

    def init(_) do
      {:producer, 0}
    end

    def handle_demand(demand, last_asked) do
      if now() - last_asked < (@interval / 2) do
        raise "failed"
      else
        {:noreply, Enum.take(Stream.repeatedly(&:rand.uniform/0), demand), now()}
      end
    end

    defp now() do
      System.system_time(:milliseconds)
    end
  end

  @tag :skip
  test "rate limiting" do
    {:ok, producer} = GenStage.start_link(Producer, nil)
    {:ok, consumer} = GenStage.start_link(Lab3.RateLimitedConsumer, nil)

    GenStage.sync_subscribe(consumer, to: producer, max_demand: 10)

    Process.sleep(2000)
  end
end
