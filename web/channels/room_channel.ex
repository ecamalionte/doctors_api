defmodule DoctorsApi.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:secret", _params, _socket ) do
    {:error, %{reason: "unauthorized"} }
  end

  def handle_in("new_message", %{ "body" => body}, socket) do
    broadcast! socket, "new_message", %{body: body}
    {:noreply, socket}
  end
end
