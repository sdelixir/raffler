defmodule Raffler.RaffleController do
  use Raffler.Web, :controller
  alias Raffler.Raffle

  def index(conn, _params) do
    raffles = Repo.all(Raffle)

    render conn, "index.html", raffles: raffles
  end

  def show(conn, %{"id" => id}) do
    raffle = Repo.get(Raffle, id)
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

end
