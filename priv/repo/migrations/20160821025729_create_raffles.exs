defmodule Raffler.Repo.Migrations.CreateRaffle do
  use Ecto.Migration

  def change do
    create table(:raffles) do
      add :date, :date, null: false

      timestamps
    end
  end
end
