defmodule Raffler.PageController do
  use Raffler.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
