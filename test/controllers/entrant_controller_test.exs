defmodule EntrantControllerTest do
  use Raffler.ConnCase

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

end
