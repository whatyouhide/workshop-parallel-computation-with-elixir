# Lab3

### Lab purpose

Learn about GenStage. We will work on exercises that will showcase some of GenStage's
"niche" features (like custom dispatchers).

### Lab instructions

  1. Implement `Lab3.InvoiceProducer`'s `init/1` callback so that this producer uses the
     `GenStage.PartitionDispatcher` dispatcher in order to dispatch events (that is, invoices) to
     the right consumer based on each invoice's region.

### Links

API docs: https://hexdocs.pm/elixir/

  1. `GenStage`: https://hexdocs.pm/gen_stage
  2. `GenStage.PartitionDispatcher`: https://hexdocs.pm/gen_stage/GenStage.PartitionDispatcher.html


### Solution ( no peeking :) )

See the `solution_*.ex` files in the `lab3` directory.
