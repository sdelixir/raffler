# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Raffler.Repo.insert!(%Raffler.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

user = %{username: "admin", password: "admin123"}
Raffler.User.registration_changeset(%Raffler.User{}, user)
|> Raffler.Repo.insert!()

raffle = %{date: "2014-01-01"}
Raffler.Raffle.changeset(%Raffler.Raffle{}, raffle)
|> Raffler.Repo.insert!()

raffle = %{date: "2014-02-01"}
Raffler.Raffle.changeset(%Raffler.Raffle{}, raffle)
|> Raffler.Repo.insert!()

raffle = %{date: "2014-03c-01"}
Raffler.Raffle.changeset(%Raffler.Raffle{}, raffle)
|> Raffler.Repo.insert!()
