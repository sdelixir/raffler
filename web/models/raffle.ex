defmodule Raffler.Raffle do
  use Raffler.Web, :model

  schema "raffles" do
    field :date, Ecto.Date

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(date), [])
  end

end
