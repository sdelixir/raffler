defmodule EntrantControllerTest do
  use Raffler.ConnCase
  alias Raffler.EntrantController

  @valid_attrs %{username: "qweqwe", phone: "123-456-7890"}
  @invalid_attrs %{}

  setup do
    raffle = insert_raffle()

    {:ok, conn: conn, raffle: raffle}
  end

  test "requires user authentication on actions", %{conn: conn, raffle: raffle} do
    Enum.each([
      get(conn, raffle_entrant_path(conn, :new, raffle)),
      get(conn, raffle_entrant_path(conn, :index, raffle)),
      post(conn, raffle_entrant_path(conn, :create, raffle), entrant: @valid_attrs),
      ], fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end)
  end

  test "extracts raffle_id and username from message body" do
    response = %{from: "123-234-3456", body: "1 someuser"}
    body = response[:body]

    assert EntrantController.raffle_id_and_username(body) == %{"raffle_id" => "1", "username" => "someuser"}
  end

  test "creates entrant for given raffle, from twilio", %{conn: conn, raffle: raffle} do

    response = %{"From" => "123-234-3456", "Body" => "#{raffle.id} some user"}
    conn = post conn, entrant_path(conn, :create_from_twilio), response

    assert html_response(conn, 200) =~ "Congratulations, some user"
  end

end
