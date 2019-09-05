defmodule Backend.App.Mixfile do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "0.0.1",
      elixir: "~> 1.9.0-slim",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      dialyzer: [
        plt_add_deps: :transitive,
        plt_add_apps: [:ex_unit, :jason, :ecto_sql, :mix],
        ignore_warnings: ".dialyzer_ignore.exs"
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Backend.App, []},
      applications: [
        :phoenix,
        :phoenix_pubsub,
        :phoenix_html,
        :cowboy,
        :logger,
        :gettext,
        :phoenix_ecto,
        :postgrex
      ],
      extra_applications: [:absinthe_plug, :httpoison]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.9"},
      {:phoenix_pubsub, "~> 1.1.2"},
      {:phoenix_ecto, "~> 4.0.0"},
      {:ecto_sql, "~>3.1.6"},
      {:postgrex, "~> 0.15.0"},
      {:phoenix_html, "~> 2.13.3"},
      {:jason, ">= 1.1.2"},
      {:phoenix_live_reload, "~> 1.2.1"},
      {:gettext, "~> 0.17.0"},
      {:cowboy, "~> 2.6.3"},
      {:plug_cowboy, "~> 2.1.0"},
      {:plug, "~> 1.8.3"},
      {:absinthe, "~> 1.4.16"},
      {:absinthe_plug, "~> 1.4.7"},
      {:absinthe_phoenix, "~> 1.4.4"},
      {:httpoison, "~> 1.5.1"},
      {:poison, ">= 4.0.1"},
      {:dataloader, "~> 1.0.0"},
      {:excoveralls, "~> 0.11.2", only: :test},
      {:credo, "~> 1.1.3", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev, :test], runtime: false},
      {:inch_ex, "~> 2.0", only: [:dev, :test]}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test.coverage": ["coveralls.html"],
      "test.coverage.short": ["coveralls"],
      dialyzer: ["dialyzer --halt-exit-status --format dialyxir"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      lint: ["credo --strict"]
    ]
  end
end
