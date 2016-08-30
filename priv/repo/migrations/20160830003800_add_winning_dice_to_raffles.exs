defmodule Raffler.Repo.Migrations.AddWinningDiceToRaffles do
  use Ecto.Migration

  def change do
    alter table(:raffles) do
      add :winning_dice, :string, default: "000"
    end
  end
end
