# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :g_crawler,
  ecto_repos: [GCrawler.Repo]

config :g_crawler, GCrawler.Repo,
  database: "ecto_simple",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"

# Configures the endpoint
config :g_crawler, GCrawlerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eiZathXo+sIzThktAW2IobS+sknnZloB7C/AbMVuXEszXwzuAOk1cLPDrkXmAO1+",
  render_errors: [view: GCrawlerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GCrawler.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "p1LJBXfU"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
