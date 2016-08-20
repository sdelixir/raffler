defmodule Raffler.User do
  use Raffler.Web, :model

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(username), [])
    |> validate_length(:username, min: 2, max: 20)
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

end
