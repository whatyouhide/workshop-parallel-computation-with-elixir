defmodule Lab3Test do
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
