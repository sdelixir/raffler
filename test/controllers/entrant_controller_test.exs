defmodule Raffler.EntrantControllerTest do
  use Raffler.ConnCase

  alias Raffler.Entrant
  @valid_attrs %{phone: 42, phone_hash: 42, username: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, entrant_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing entrants"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, entrant_path(conn, :new)
    assert html_response(conn, 200) =~ "New entrant"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, entrant_path(conn, :create), entrant: @valid_attrs
    assert redirected_to(conn) == entrant_path(conn, :index)
    assert Repo.get_by(Entrant, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, entrant_path(conn, :create), entrant: @invalid_attrs
    assert html_response(conn, 200) =~ "New entrant"
  end

  test "shows chosen resource", %{conn: conn} do
    entrant = Repo.insert! %Entrant{}
    conn = get conn, entrant_path(conn, :show, entrant)
    assert html_response(conn, 200) =~ "Show entrant"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, entrant_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    entrant = Repo.insert! %Entrant{}
    conn = get conn, entrant_path(conn, :edit, entrant)
    assert html_response(conn, 200) =~ "Edit entrant"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    entrant = Repo.insert! %Entrant{}
    conn = put conn, entrant_path(conn, :update, entrant), entrant: @valid_attrs
    assert redirected_to(conn) == entrant_path(conn, :show, entrant)
    assert Repo.get_by(Entrant, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    entrant = Repo.insert! %Entrant{}
    conn = put conn, entrant_path(conn, :update, entrant), entrant: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit entrant"
  end

  test "deletes chosen resource", %{conn: conn} do
    entrant = Repo.insert! %Entrant{}
    conn = delete conn, entrant_path(conn, :delete, entrant)
    assert redirected_to(conn) == entrant_path(conn, :index)
    refute Repo.get(Entrant, entrant.id)
  end
end
