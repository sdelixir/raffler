defmodule Raffler.EntrantChannel do
  use Phoenix.Channel
  alias Raffler.Repo
  alias Raffler.Raffle
  alias Raffler.Entrant

  def join("entrant:" <> entrant_slug, params, socket) do
    {:ok, socket}
  end

  def handle_in("request_new_dice", %{"entrantSlug" => entrant_slug}, socket) do
    IO.puts "request new dice: " <> entrant_slug
    IO.puts "raffle_id: " <> socket.assigns[:raffle_id]
    raffle_id = socket.assigns[:raffle_id]

    raffle = Raffle |> Repo.get(raffle_id)

    dice = rand
    broadcast! socket, "receive_new_dice", %{"dice" => dice}

    cond do
      dice = raffle.winning_dice ->
        Raffler.Endpoint.broadcast "raffle:3", "raffle over", %{body: "raffle_over"}
    end

    {:noreply, socket}
  end

  defp rand do
    Enum.take_random(1..6, 3)
  end

  defp winner?(list, raffle_id) do
    list == Raffle.dice(raffle_id)
  end

end
