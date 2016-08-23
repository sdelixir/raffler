use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :raffler, Raffler.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure your database
config :raffler, Raffler.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: 20

# Configure Twilio
config :ex_twilio, account_sid: System.get_env("ACCOUNT_SID")
                   auth_token: System.get_env("AUTH_TOKEN")
