defmodule Raffler.Entrant do
  use Raffler.Web, :model

  schema "entrants" do
    field :username, :string
    field :phone, :string, virtual: true
    field :phone_hash, :string
    belongs_to :raffle, Raffler.Raffle

    timestamps
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(phone), [])
    |> put_pass_hash()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(username), [])
    |> validate_length(:username, min: 1, max: 20)
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{phone: phone}} ->
        put_change(changeset, :phone_hash, Comeonin.Bcrypt.hashpwsalt(phone))
      _ ->
        changeset
    end
  end

end