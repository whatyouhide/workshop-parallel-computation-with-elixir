# Lab4

### Lab purpose

Learn about Flow. We will extend on streams and GenStage to express computation flows on large
collections of data.

### Lab instructions

The `lab4` directory has a file `lib/lab4.ex` which contains an implementation of chat
room with some stubbed out functions. As usual, use that template to implement functions
until all tests pass.

  1. Use Flow to a sum an enumerable of integers. Tips: Use `Enum.chunk_every/2` to split the enum
     and `Flow.from_enumerables/1` to build a Flow producer from the list.

  2. Return N most frequent words. Tips: Use the provided `normalize_string/1` function and pass
     the `trim: true` option to `String.split/2`.

### Links

API docs: https://hexdocs.pm/elixir/

  1. `Flow/1` https://hexdocs.pm/flow

  2. `Flow.from_enumerables/1` - https://hexdocs.pm/flow/Flow.html#from_enumerables/2

  3. `Flow.reduce/3` - https://hexdocs.pm/flow/Flow.html#reduce/3

  4. `Flow.emit/2` - https://hexdocs.pm/flow/Flow.html#emit/2


### Solution ( no peeking :) )

See `solution.ex` in the `lab4` directory.
