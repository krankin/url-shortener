# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shorty,
  ecto_repos: [Shorty.Repo]

# Configures the endpoint
config :shorty, ShortyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uHi0QiLKl3Gaj0oOsyoXmHt9eed+kwt2g1zNXfrA5mGP5LOSBuiHeAdGfo1kBUAH",
  render_errors: [view: ShortyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Shorty.PubSub,
  live_view: [signing_salt: "hE1gT26T"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
