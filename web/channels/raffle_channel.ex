defmodule Raffler.RaffleChannel do
  use Phoenix.Channel
  alias Raffler.Repo
  alias Raffler.Raffle
  alias Raffler.Entrant

  def join("raffle:" <> raffle_id, params, socket) do
    {:ok, socket}
  end

  def handle_in("set_winning_dice", %{"raffleId" => raffle_id}, socket) do
    raffle_id = socket.assigns[:raffle_id]
    raffle = set_winning_dice(raffle_id)

    broadcast! socket, "receive_new_dice", %{"dice" => raffle.winning_dice}
    {:noreply, socket}
  end

  def handle_in("start-raffle", params, socket) do
    send_countdown(socket)
    {:noreply, socket}
  end

  defp rand do
    Enum.take_random(1..6, 3)
  end

  defp set_winning_dice(raffle_id) do
    raffle = Raffle |> Repo.get(raffle_id)
    dice = rand

    changeset = Raffle.changeset(raffle, %{winning_dice: Enum.join dice})
    Repo.update! changeset
  end

  defp send_countdown(socket) do
    broadcast! socket, "start-raffle", %{msg: "GET READY!"}
    :timer.sleep(1000)
    broadcast! socket, "start-raffle", %{msg: "3!"}
    :timer.sleep(1000)
    broadcast! socket, "start-raffle", %{msg: "2!"}
    :timer.sleep(1000)
    broadcast! socket, "start-raffle", %{msg: "1!"}
    :timer.sleep(1000)
    broadcast! socket, "start-raffle", %{msg: "SHAKE!"}
  end

end
