defmodule EntrantControllerTest do
  use Raffler.ConnCase
  alias Raffler.Raffle
  alias Raffler.Entrant

  @valid_attrs %{username: "qweqwe", phone: "123-456-7890"}
  @invalid_attrs %{}

  setup do
    raffle = insert_raffle()

    {:ok, conn: conn, raffle: raffle}
  end

  test "GET /raffle/:id/entrants - shows activated list of entrants", %{conn: conn, raffle: raffle} do
    conn = get conn, raffle_entrant_path(conn, :index, raffle.id)

    assert html_response(conn, 200) =~ "Register for Raffle #{raffle.id}"
  end

  test "GET /raffles/:id/entrants/new", %{conn: conn, raffle: raffle} do
    conn = get conn, raffle_entrant_path(conn, :new, raffle.id)

    assert html_response(conn, 200) =~ "New Entrant for raffle #{raffle.id}"
  end

  test "POST /raffles/:id/entrants - redirects to raffle show", %{conn: conn, raffle: raffle} do
    conn = post conn, raffle_entrant_path(conn, :create, raffle), entrant: @valid_attrs

    assert redirected_to(conn) == raffle_path(conn, :show, raffle)
  end

end
