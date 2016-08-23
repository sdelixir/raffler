defmodule Raffler.Repo.Migrations.CreateEntrant do
  use Ecto.Migration

  def change do
    create table(:entrants) do
      add :username, :string, null: false
      add :phone_hash, :string

      timestamps
    end
  end
end
