defmodule Raffler.EntrantController do
  use Raffler.Web, :controller
  alias Raffler.Repo
  alias Raffler.Raffle
  alias Raffler.Entrant

  def index(conn, _params) do
    entrants = Repo.all(Entrant)

    render conn, "index.html", entrants: entrants
  end

  def new(conn, %{"raffle_id" => raffle_id}) do
    changeset = Entrant.changeset(%Entrant{})

    render conn, "new.html", changeset: changeset, raffle_id: raffle_id
  end

  def show(conn, %{"id" => id}) do
    entrant = Entrant |> Repo.get(id)
    render conn, "show.html", entrant: entrant
  end

  def create(conn, %{"entrant" => entrant_params}) do
    changeset = Entrant.registration_changeset(%Entrant{}, entrant_params)

    case Repo.insert(changeset) do
      {:ok, entrant} ->
        conn
        |> put_flash(:info, "Entrant created successfully.")
        |> redirect(to: raffle_path(conn, :show, entrant.raffle_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, raffle_id: changeset.changes.raffle_id)
    end
  end

  def create_from_twilio(conn, %{"Body" => body, "From" => phone}) do
    %{username: username, raffle_id: raffle_id} = raffle_id_and_username(body)
    changeset = Entrant.registration_changeset(%Entrant{}, %{username: username, raffle_id: raffle_id, phone: phone})

    case Repo.insert(changeset) do
      {:ok, entrant} ->
        conn
        |> render "registration.html", entrant: entrant, layout: false
      {:error, changeset} ->
        conn
        |> render "registration-error.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    entrant = Entrant |> Repo.delete!(id)
  end

  defp phone_hash(phone) do
    s = Hashids.new([salt: "PHONE_HASH_SEED", min_len: 5])
    Hashids.encode(s, phone)
  end

  defp find_or_create_by(phone) do
    Entrant |> Repo.get_by(phone_hash: phone_hash(phone)) ||
      new_entrant(phone)
  end

  defp new_entrant(phone) do
    changeset = Entrant.registration_changeset(%Entrant{}, %{phone: phone})
    Repo.insert! changeset
  end

  def raffle_id_and_username(string) do
    Regex.named_captures(~r/(?<raffle_id>^\d+)\s*(?<username>.+)/, string)
  end

end
