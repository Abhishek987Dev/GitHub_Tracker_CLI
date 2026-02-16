defmodule GithubTracker.MixProject do
  use Mix.Project

  def project do
    [
      app: :github_tracker,
      version: "0.1.0",
      elixir: "~> 1.19",
      escript: escript_config(),
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

  defp escript_config do
    [
      main_module: GithubTracker
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.4.0"},
      {:jason, "~> 1.4"},
      {:table_rex, "~> 3.1"}
    ]
  end
end
