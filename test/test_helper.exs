ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Raffler.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Raffler.Repo --quiet)
# Ecto.Adapters.SQL.begin_test_transaction(Raffler.Repo)
Ecto.Adapters.SQL.Sandbox.mode(Raffler.Repo, :manual)
