defmodule Raffler.RaffleControllerTest do
  use Raffler.ConnCase
  alias Raffler.Raffle

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

  test "GET /raffles/new", %{conn: conn} do
    conn = get conn, raffle_path(conn, :new)

    assert html_response(conn, 200) =~ "New Raffle"
  end

  test "GET /raffles/:id - shows entrants for given raffle", %{conn: conn, raffle: raffle} do
    raffle_entrant = insert_entrant(raffle: raffle)
    other_entrant =  insert_entrant(raffle: insert_raffle())
    conn = get conn, raffle_path(conn, :show, raffle)

    assert html_response(conn, 200) =~ "(#{raffle.id}) - Raffle - #{raffle.date}"
    assert html_response(conn, 200) =~ ~r/Entrants/
  end

  test "POST /raffles - creates raffle and redirects when valid", %{conn: conn} do
    conn = post(conn, raffle_path(conn, :create), raffle: @valid_attrs)

    assert redirected_to(conn) == raffle_path(conn, :index)
  end

  test "POST /raffles - does not create raffle and renders error when invalid", %{conn: conn} do
    count_before = raffle_count(Raffle)
    conn = post conn, raffle_path(conn, :create), raffle: @invalid_attrs

    assert html_response(conn, 200) =~ "check the errors"
    assert raffle_count(Raffle) == count_before
  end

  defp raffle_count(query), do: Repo.one(from v in query, select: count(v.id))
end
