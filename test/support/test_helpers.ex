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

end
