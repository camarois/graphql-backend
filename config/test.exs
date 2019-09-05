use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :app, Backend.App.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :app, Backend.App.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "app_development_test",
  url: "postgres://postgres:postgres@postgres/app_development_test",
  pool: Ecto.Adapters.SQL.Sandbox
