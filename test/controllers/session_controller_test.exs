defmodule Raffler.SessionControllerTest do
  use Raffler.ConnCase

  test "GET /session/new", %{conn: conn} do
    conn = get conn, "/session/new"

    assert html_response(conn, 200) =~ "Login"
  end

  test "POST /session - redirects when valid", %{conn: conn} do
    user = insert_user
    conn = post conn, session_path(conn, :create), %{"session" => %{"username" => user.username, "password" => user.password}}

    assert redirected_to(conn) == raffle_path(conn, :index)
  end

end
