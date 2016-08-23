defmodule Raffler.EntrantController do
  use Raffler.Web, :controller
  import Raffler.Auth, only: [authenticate_user: 2]
  alias Raffler.Repo
  alias Raffler.Raffle
  alias Raffler.Entrant

  plug :authenticate_user, [] when action in [:index, :new, :create]

  def index(conn, %{"raffle_id" => raffle_id}) do
    raffle = Raffle |> Repo.get(raffle_id) |> Repo.preload([:entrants])
    render(conn, "index.html", raffle: raffle)
  end

  def new(conn, params) do
    raffle = Raffler.Repo.get(Raffle, params["raffle_id"])

    changeset =
      raffle
      |> build_assoc(:entrants)
      |> Entrant.changeset()
    render(conn, "new.html", changeset: changeset, raffle: raffle)
  end

  def create(conn, %{"entrant" => entrant_params, "raffle_id" => raffle_id}) do
    raffle = Raffle |> Repo.get(raffle_id)
    changeset =
      raffle
      |> build_assoc(:entrants)
      |> Entrant.changeset(entrant_params)

    case Repo.insert(changeset) do
      {:ok, _video} ->
        conn
        |> put_flash(:info, "Successfully entered the raffle.")
        |> redirect(to: raffle_path(conn, :show, raffle))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create_from_twilio(conn, params) do
    %{"body" => body, "from" => phone} = params
    IO.puts "from"
    IO.puts phone
    IO.puts "body"
    IO.puts body
    # %{raffle_id: raffle_id, username: username} = raffle_id_and_username(body)
    # entrant_params = %{username: username, phone: phone}
    # raffle = Raffle |> Repo.get(raffle_id)
    # changeset =
    #   raffle
    #   |> build_assoc(:entrants)
    #   |> Entrant.changeset(entrant_params)
    #
    # case Repo.insert(changeset) do
    #   {:ok, _video} ->
    #     conn
    #     |> render(conn, :registration, raffle)
    #   {:error, changeset} ->
    #     render(conn, "registration-error.html")
    # end
  end

  def raffle_id_and_username(string) do
    Regex.named_captures(~r/(?<raffle_id>^\d+)\s*(?<username>.+)/, string)
  end

end
