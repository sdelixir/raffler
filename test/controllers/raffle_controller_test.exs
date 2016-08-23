defmodule Raffler.RaffleControllerTest do
  use Raffler.ConnCase

  @valid_attrs %{date: current_date}
  @invalid_attrs %{}

  setup do
    raffle = insert_raffle

    {:ok, conn: conn, raffle: raffle}
  end

  test "GET /raffles", %{conn: conn} do
    conn = get conn, raffle_path(conn, :index)

    assert html_response(conn, 200) =~ "Past Raffles"
  end

  test "GET /raffles/:id - shows entrants for given raffle", %{conn: conn, raffle: raffle} do
    conn = get conn, raffle_path(conn, :show, raffle)

    assert html_response(conn, 200) =~ "(#{raffle.id}) - Raffle - #{raffle.date}"
    assert html_response(conn, 200) =~ ~r/Entrants/
  end

end
