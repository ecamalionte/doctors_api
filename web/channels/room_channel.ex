defmodule DoctorsApi.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:secret", _params, _socket ) do
    {:error, %{reason: "unauthorized"} }
  end

  def handle_in("new_message", %{ "body" => body, "user" => user }, socket) do
    broadcast! socket, "new_message", %{body: body, user: user}
    {:noreply, socket}
  end

  def handle_in("typing", %{ "user" => user }, socket) do
    broadcast! socket, "typing", %{user: user}
    {:noreply, socket}
  end
end
