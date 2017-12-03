use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :peeping, PeepingWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :peeping, Peeping.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "byelipk",
  password: "phoenix4dev",
  database: "peeping_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox