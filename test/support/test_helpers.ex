defmodule Raffler.TestHelpers do
  alias Raffler.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      username: "user#{Base.encode16(:crypto.rand_bytes(8))}",
      password: "supersecret",
    }, attrs)

    %Raffler.User{}
    |> Raffler.User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_raffle(attrs \\ %{}) do
    changes = Dict.merge(%{
      date: current_date
      }, attrs)

    %Raffler.Raffle{}
    |> Raffler.Raffle.changeset(changes)
    |> Repo.insert!()
  end

  def current_date do
    :calendar.local_time
    |> Ecto.DateTime.from_erl
    |> Ecto.DateTime.to_date
    |> Ecto.Date.to_string
  end

end
