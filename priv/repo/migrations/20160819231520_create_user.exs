defmodule Raffler.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :password_hash, :string

      timestamps
    end
  end
end
