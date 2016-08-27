defmodule Raffler.EntrantTest do
  use Raffler.ModelCase
  alias Raffler.User
  alias Raffler.Entrant
  alias Raffler.Repo
  alias Raffler.Raffle

  @valid_attrs %{phone: 42, username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Entrant.changeset(%Entrant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entrant.changeset(%Entrant{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset does not accept long usernames" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))

    assert {:username, {"should be at most %{count} character(s)", [count: 20]}} in
      errors_on(%User{}, attrs)
  end
end
