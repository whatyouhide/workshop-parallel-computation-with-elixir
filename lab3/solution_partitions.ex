defmodule Lab3.InvoiceProducer do
  use GenStage

  def start_link(regions) do
    GenStage.start_link(__MODULE__, regions, name: __MODULE__)
  end

  def init(regions) do
    dispatcher = {GenStage.PartitionDispatcher, partitions: regions, hash: &partition_hash/1}
    {:producer, regions, dispatcher: dispatcher}
  end

  defp partition_hash(event) do
    {event, event.region}
  end

  def handle_demand(demand, regions) do
    events = Enum.take(invoice_generator(regions), demand)
    {:noreply, events, regions}
  end

  defp invoice_generator(regions) do
    import StreamData

    fixed_map(%{
      region: member_of(regions),
      amount: positive_integer(),
      name: string(:alphanumeric)
    })
  end
end
