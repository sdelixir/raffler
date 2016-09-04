defmodule Raffler.RaffleController do
  use Raffler.Web, :controller
  import Raffler.Auth, only: [authenticate_user: 2]
  alias Raffler.Raffle

  plug :authenticate_user, [] when action in [:new, :create, :show, :edit, :update]

  def index(conn, _params) do
    raffles = Repo.all(Raffle)

    render conn, "index.html", raffles: raffles
  end

  def show(conn, %{"id" => id}) do
    raffle = Raffle |> Repo.get(id) |> Repo.preload([:entrants])

    render conn, "show.html", raffle: raffle
  end

  def new(conn, _params) do
    changeset = Raffle.changeset(%Raffle{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"raffle" => raffle_params}) do
    changeset = Raffle.changeset(%Raffle{}, raffle_params)

    case Repo.insert(changeset) do
      {:ok, _raffle} ->
        conn
        |> put_flash(:info, "Raffle created successfully.")
        |> redirect(to: raffle_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    raffle = Raffle |> Repo.get!(id)
    changeset = Raffle.changeset(raffle, %{})

    render(conn, "edit.html", raffle: raffle, changeset: changeset)
  end

  def update(conn, %{"id" => id, "raffle" => raffle_params}) do

    raffle = Raffle |> Repo.get(id)
    changeset = Raffle.changeset(raffle, raffle_params)

    case Repo.update(changeset) do
      {:ok, raffle} ->
        conn
        |> put_flash(:info, "Raffle updated successfully.")
        |> redirect(to: raffle_path(conn, :show, raffle))
      {:error, changeset} ->
        render(conn, "edit.html", raffle: raffle, changeset: changeset)
    end
  end

end
