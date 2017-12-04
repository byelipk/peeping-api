# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :peeping,
  ecto_repos: [Peeping.Repo]

# Configures the endpoint
config :peeping, PeepingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A6yqTebWL6AM4AyTZ/gXIAgFs2V9QIN/QGBw4h9hp+bf1a7NO1p1yXbqa0SED2VV",
  render_errors: [view: PeepingWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Peeping.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders,
  "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "peeping",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET") || "JIPIhQZPikQ7TYhjE3tbj2BBfyxNf5LbcAbaIioX0m82JLgV4AAxWVeweFbGo7w5",
  serializer: Peeping.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
