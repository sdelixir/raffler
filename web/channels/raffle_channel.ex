defmodule Raffler.RaffleChannel do
  use Phoenix.Channel
  use Phoenix.Socket
  alias Raffler.Raffle

  def join("raffle:lobby", message, socket) do
    {:ok, socket}
  end
  def join("raffle:" <> entrant_id, params, socket) do
    socket = assign(socket, :entrant_id, params["entrantId"])
    socket = assign(socket, :raffle_id,  params["raffleId"])

    {:ok, socket}
  end

  def handle_in("request_new_dice", %{"entrantId" => entrant_id}, socket) do
    dice = rand
    IO.puts "socket.assigns"
    IO.puts socket.assigns
    broadcast! socket, "receive_new_dice", %{"dice" => dice}
    {:noreply, socket}
  end

  defp rand do
    Enum.take_random(1..6, 3)
  end

  defp winner?(list, raffle_id) do
    list == Raffle.dice(raffle_id)
  end

end
