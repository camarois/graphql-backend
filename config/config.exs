# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :phoenix, :json_library, Jason

# General application configuration
config :app,
  namespace: Backend.App,
  ecto_repos: [Backend.App.Repo]

config :app, Backend.App.Repo,
  database: "app_development",
  username: "postgres",
  password: "postgres",
  hostname: "db",
  port: "5432"  

# Configures the endpoint
config :app, Backend.App.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CHl5IEpo2T9iE5TWtSzr1dUS49XQRNV8gJdpcOo0kvXAwOatsy1Aj3+gQ0OQch9v",
  render_errors: [view: Backend.App.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Backend.App.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
