defmodule Fantastic.Mixfile do
  use Mix.Project

  def project do
    [app: :fantastic,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [:logger],
      mod: {Fantastic, [:logger, :cowboy, :plug, :postgrex, :ecto]}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug,   "~> 0.7.0"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 0.2.0"},
      {:ecto_riak_adapter, git: "/Users/HashNuke/projects/ecto_riak_adapter", branch: "master"},
      {:riak_pb, github: "HashNuke/riak_pb", branch: "plugin-fix-for-rebar-2.5.1", override: true},
      {:exrm, "~> 0.14.9"},
      {:rotor, "~> 0.2.2"},
      {:coffee_rotor, "~> 0.2.1"}
    ]
  end
end
