defmodule Raffler.Repo.Migrations.AddEntrantsToRaffle do
  use Ecto.Migration

  def change do
    alter table(:entrants) do
      add :raffle_id, references(:raffles)
    end
  end
end
