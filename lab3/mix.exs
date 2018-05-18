defmodule Lab3.MixProject do
  use Mix.Project

  def project do
    [
      app: :lab3,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gen_stage, "~> 0.13.1"},
      {:stream_data, "~> 0.4.2"}
    ]
  end
end
