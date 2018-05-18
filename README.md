# README

### Lab requirements

  1. Install git
     - Windows: Install via https://git-scm.com
     - OS X: Install with package manager or https://git-scm.com
     - Linux: Install via distribution package manager or https://git-scm.com

  2. Install Erlang & Elixir (at least 1.6)
     - See https://elixir-lang.org/install.html

##### Verify your installations

Verify your installation by calling the executables `git`, `erl` and `iex` in
your shell. Your Erlang installation needs to be on OTP 19 and Elixir on 1.6
or higher. Check the version by running `iex`:

```
~ λ iex
Erlang/OTP 20 [erts-9.3] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:10] [hipe] [kernel-poll:false]

Interactive Elixir (1.6.5) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
```


### Installing a lab

The repository for all labs is found at https://github.com/whatyouhide/workshop-parallel-computation-with-elixir.

  1. git clone from your console

     ```bash
     $ git clone https://github.com/whatyouhide/workshop-parallel-computation-with-elixir
     ```

  2. Enter the workshop directory

     ```bash
     $ cd workshop-parallel-computation-with-elixir
     ```

  2. Enter the directory for the current lab named `labN`. For example, for `lab1`:
     
     ```bash
     $ cd lab1
     ```


### Running tests

As you start out with a new lab all tests will be skipped with `@tag :skip`, remove this tag when
you start working on a test.


Tests are tagged with `@tag :skip`. When you run `mix test`, all tests are skipped so you will see
all tests "passing". You should remove or comment out the `@tag :skip` line above the first test
and then run tests to see that test fail. Then, implement the first function until the test
passes. Repeat for all other functions.

 * Run all tests for a project: `$ mix test`

 * Run all tests in a specific file: `$ mix test test/my_test.exs`

 * Run all tests on a specific file and line: `$ mix test test/my_test.exs:42`


### Lab links

The individual labs can be found at the following URLs:

*Lab 1* - Process basics: https://github.com/whatyouhide/workshop-parallel-computation-with-elixir/tree/master/lab1

*Lab 2* - Streams and tasks: https://github.com/whatyouhide/workshop-parallel-computation-with-elixir/tree/master/lab2

*Lab 3* - GenStage: https://github.com/whatyouhide/workshop-parallel-computation-with-elixir/tree/master/lab3

*Lab 4* - Flow: https://github.com/whatyouhide/workshop-parallel-computation-with-elixir/tree/master/lab4
