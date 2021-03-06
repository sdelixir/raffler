defmodule Raffler.Mixfile do
  use Mix.Project

  def project do
    [app: :raffler,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test],

     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Raffler, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :comeonin]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, github: "phoenixframework/phoenix", override: true},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_ecto, github: "phoenixframework/phoenix_ecto"},
      {:phoenix_html, github: "phoenixframework/phoenix_html", override: true},
      {:phoenix_live_reload, github: "phoenixframework/phoenix_live_reload", only: :dev},
      {:gettext, github: "elixir-lang/gettext"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 2.5"},
      {:excoveralls, "~> 0.5", only: :test},
      {:ex_twilio, "~> 0.2.0"},
      {:credo, "~> 0.4", only: [:dev, :test]},
      {:hashids, "~> 2.0"},
   ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end
