defmodule Raffler.EntrantView do
  use Raffler.Web, :view

  def race_path(conn, entrant) do
    Raffler.Router.Helpers.race_url(conn, :show, entrant.phone_hash)
  end
end
