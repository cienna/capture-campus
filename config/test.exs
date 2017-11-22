use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :capturecampus, CapturecampusWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :capturecampus, Capturecampus.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "campus",
  password: "ahpalah0Xu7u",
  database: "capturecampus_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
