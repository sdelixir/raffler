defmodule Raffler.Raffle do
  use Raffler.Web, :model
  alias Raffle.Entrant
  alias Raffle.Entry
  alias Raffle.Raffle

  schema "raffles" do
    field :date, Ecto.Date
    field :winning_dice, :string, default: "000"
    has_many :entrants, Raffler.Entrant

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(date winning_dice), [])
  end

end
