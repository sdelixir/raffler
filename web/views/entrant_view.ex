defmodule Raffler.EntrantView do
  use Raffler.Web, :view

  def race_url(conn, entrant) do
    Raffler.Router.Helpers.raffle_entrant_url(conn, :show, entrant.raffle_id, entrant.phone_hash)
  end
end
