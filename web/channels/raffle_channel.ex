defmodule Raffler.RaffleChannel do
  use Phoenix.Channel
  alias Raffler.Repo
  alias Raffler.Raffle
  alias Raffler.Entrant

  def join("raffle:" <> raffle_id, params, socket) do
    
    {:ok, socket}
  end

  def handle_in("raffle_channel test", %{"body" => body}, socket) do
    IO.puts "raffle_channel test: " <> body

    broadcast! socket, "raffle_channel test", %{"body" => body}
    {:noreply, socket}
  end

  def handle_out() do

  end

end
