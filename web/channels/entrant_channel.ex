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

    dice = get_rand_dice()

    broadcast! socket, "receive_new_dice", %{"dice" => dice}

    cond do
      Enum.join(dice) == raffle.winning_dice ->
        Raffler.Endpoint.broadcast "raffle:#{raffle.id}", "raffle over", %{msg: "Raffle Over"}
        broadcast! socket, "entrant win", %{"msg" => "YOU WON!!!"}
      true ->
        false
    end

    {:noreply, socket}
  end

  defp get_rand_dice do
    Enum.take_random(1..6, 3)
  end

  defp winner?(list, raffle_id) do
    list == Raffle.dice(raffle_id)
  end

end
