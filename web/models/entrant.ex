defmodule Raffler.Entrant do
  use Raffler.Web, :model

  schema "entrants" do
    field :username, :string
    field :phone, :string, virtual: true
    field :phone_hash, :string
    belongs_to :raffle, Raffler.Raffle

    timestamps()
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(phone raffle_id), [])
    |> put_pass_hash()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(username), [])
    |> validate_length(:username, min: 2, max: 20)
    |> foreign_key_constraint(:raffle_id)
    |> unique_constraint(:phone_hash_raffle_id)
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{phone: phone}} ->
        put_change(changeset, :phone_hash, Comeonin.Bcrypt.hashpass(phone, "$2b$12$HzpGbGRSsSuIKDygpE6CAO"))
      _ ->
        changeset
    end
  end
end
