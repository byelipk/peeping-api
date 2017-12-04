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
  hostname: "localhost",
  username: System.get_env("DB_USER"),
  password: System.get_env("DB_PASS"),
  database: "#{System.get_env("DB_NAME")}_test",
  pool: Ecto.Adapters.SQL.Sandbox

# Speed up hashing during tests
config :pbkdf2_elixir, :rounds, 1

