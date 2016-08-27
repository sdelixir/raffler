defmodule Raffler.Repo.Migrations.CreateEntrant do
  use Ecto.Migration

  def change do
    create table(:entrants) do
      add :username, :string
      add :phone_hash, :string
      add :raffle_id, references(:raffles, on_delete: :nothing)

      timestamps()
    end
    create index(:entrants, [:raffle_id])
    create index(:entrants, [:phone_hash, :raffle_id], unique: true)
  end
end
