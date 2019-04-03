# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :videorama,
  ecto_repos: [Videorama.Repo]

# Configures the endpoint
config :videorama, VideoramaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rs0EgrI+OjHUBat38jwCsx5OB9H0zcNGN/DDV7LWk2LQ5KE8b8OcEkcDE4tETeuI",
  render_errors: [view: VideoramaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Videorama.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
