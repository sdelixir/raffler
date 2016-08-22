defmodule Raffler.RaffleTest do
  use Raffler.ModelCase, async: true

  alias Raffler.Raffle

  @valid_attrs %{date: "2014-04-17"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Raffle.changeset(%Raffle{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Raffle.changeset(%Raffle{}, @invalid_attrs)
    refute changeset.valid?
  end

end
