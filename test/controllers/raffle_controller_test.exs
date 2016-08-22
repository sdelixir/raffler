defmodule Raffler.RaffleControllerTest do
  use Raffler.ConnCase
  alias Raffler.Raffle

  @valid_attrs %{date: current_date}
  @invalid_attrs %{}

  test "GET /raffles", %{conn: conn} do
    conn = get conn, "/raffles"
    assert html_response(conn, 200) =~ "Past Raffles"
  end

  test "GET /raffles/new", %{conn: conn} do
    conn = get conn, "/raffles/new"
    assert html_response(conn, 200) =~ "New Raffle"
  end

  test "GET /raffles/show", %{conn: conn} do
    raffle = insert_raffle()
    conn = get conn, "/raffles/#{raffle.id}"
    assert html_response(conn, 200) =~ "(#{raffle.id}) - Raffle - #{raffle.date}"
  end

  test "POST /raffle - creates raffle and redirects", %{conn: conn} do
    conn = post conn, raffle_path(conn, :create), raffle: @valid_attrs

    assert redirected_to(conn) == raffle_path(conn, :index)
  end

  test "does not create video and renders error when invalid", %{conn: conn} do
    count_before = raffle_count(Raffle)
    conn = post conn, raffle_path(conn, :create), raffle: @invalid_attrs

    assert html_response(conn, 200) =~ "check the errors"
    assert raffle_count(Raffle) == count_before
  end

  defp raffle_count(query), do: Repo.one(from v in query, select: count(v.id))
end
