defmodule Raffler.RaffleView do
  use Raffler.Web, :view

  def current_date do
    :calendar.local_time
    |> Ecto.DateTime.from_erl
    |> Ecto.DateTime.to_date
    |> Ecto.Date.to_string
  end
end
