# referenced https://medium.com/@miguel.coba/building-a-game-with-phoenix-channels-a3e6b390cfcc

defmodule CapturecampusWeb.GameChannel do
  use CapturecampusWeb, :channel
  alias Phoenix.Socket

  def join("game:" <> invite_code, payload, socket) do
#    send(self, {:after_join, payload})
    socket = socket
    |> Socket.assign(:code, invite_code)
    |> Socket.assign(:player, payload["user"])
    {:ok, socket}
  end

  # building was captured by the given team
  def handle_in("building_captured", %{"building" => building, "team" => team}, socket) do
    broadcast! socket, "building_captured", %{building: building, team: team}
    {:noreply, socket}
  end

  # a player has joined the game
  def handle_in("player_join", %{"player" => player}, socket) do
    broadcast! socket, "player_join", %{player: player}
    {:noreply, socket}
  end

#  def handle_out("building_captured", payload, socket) do
#    push socket, "building_captured", payload
#    {:noreply, socket}
#  end

#  def handle_info({:after_join, _message}, socket) do
#
#  end

  defp authorized?(_payload) do
    true
  end
end
