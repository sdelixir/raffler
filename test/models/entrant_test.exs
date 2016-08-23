defmodule EntrantTest do
  use Raffler.ModelCase, async: true
  alias Raffler.Entrant

  @valid_attrs %{raffle_id: 1, username: "user", phone: "123-456-7890"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Entrant.changeset(%Entrant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entrant.changeset(%Entrant{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "registration_changeset with valid attributes hashes phone_number" do
    changeset = Entrant.registration_changeset(%Entrant{}, @valid_attrs)
    %{phone: phone, phone_hash: phone_hash} = changeset.changes

    assert changeset.valid?
    assert phone_hash
    assert Comeonin.Bcrypt.checkpw(phone, phone_hash)
  end

end
