defmodule Raffler.RaffleChannel do
  use Phoenix.Channel

  def join("raffle:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("raffle:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("request_new_dice", %{"entrantId" => entrant_id}, socket) do
    dice = rand
    Enum.each(dice, &IO.puts(&1))
    broadcast! socket, "receive_new_dice", %{"dice" => dice}
    {:noreply, socket}
  end

  def rand do
    Enum.take_random(1..6, 3)
  end

end
