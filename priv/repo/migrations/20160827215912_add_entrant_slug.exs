defmodule Raffler.Repo.Migrations.AddEntrantSlug do
  use Ecto.Migration

  def change do
    alter table(:entrants) do
      add :slug, :string
    end
    create index(:entrants, [:slug], unique: true)
  end
end
