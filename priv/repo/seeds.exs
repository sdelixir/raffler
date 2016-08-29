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

alias Raffler.Repo
alias Raffler.User
alias Raffler.Raffle
alias Raffler.Entrant

# Admin

users = [
  %{username: "admin", password: "admin123"},
]

cond do
  Repo.all(User) != [] ->
    IO.puts "Users detected, aborting user seed."
  true ->
    Enum.each(users, fn user ->
      %User{}
      |> User.registration_changeset(user)
      |> Repo.insert!()
    end)
end

# Raffles

raffle = [
  %{date: "2014-01-01"},
  %{date: "2014-02-01"},
  %{date: "2014-03-01"},
]

cond do
  Repo.all(Raffle) != [] ->
    IO.puts "Raffles detected, aborting raffle seed."
  true ->
    Enum.each(raffles, fn raffle ->
      %Raffle{}
      |> Raffle.changeset(raffle)
      |> Repo.insert!()
    end)
end

# Entrants

entrants = [
  %{username: "ABC", phone: "123-234-3456", raffle_id: 1},
  %{username: "DEF", phone: "123-234-3456", raffle_id: 2},
  %{username: "GHI", phone: "123-234-3456", raffle_id: 3},
]

cond do
  Repo.all(Entrant) != [] ->
    IO.puts "Entrants detected, aborting entrant seed."
  true ->
    Enum.each(entrants, fn entrant ->
      %Entrant{}
      |> Entrant.changeset(entrant)
      |> Repo.insert!()
    end)
end
