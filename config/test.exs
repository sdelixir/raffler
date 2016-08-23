use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :raffler, Raffler.Endpoint,
  secret_key_base: "AXbzSOm3lOo4mvtTn7N4z8VAx+O/0/oTP3sk+iXYTFjaAudoM6xxlFIDpav9WITl",
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :raffler, Raffler.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "raffler_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
