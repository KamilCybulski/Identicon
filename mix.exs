defmodule Identicon.Mixfile do
  use Mix.Project

  def project do
    [
      app: :identicon,
      escript: escript_config,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
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
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:egd, github: "erlang/egd"}
    ]
  end

  defp escript_config do
    [main_module: Identicon.CLI]
  end
end
