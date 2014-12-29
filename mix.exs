defmodule Potion.Mixfile do
  use Mix.Project

  def project do
    [
      app: :potion,
      version: "0.0.1",
      elixir: "~> 1.0",
      deps: deps,
      escript: [
        main_module: ExamplePotion
      ]
    ]
  end

  def application do
    [
      applications: [ :logger ]
    ]
  end

  defp deps do
    []
  end
end