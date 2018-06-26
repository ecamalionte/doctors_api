defmodule DoctorsApi.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:secret", _params, _socket ) do
    {:error, %{reason: "unauthorized"} }
  end

  def handle_in("new_message", %{ "body" => body, "user_id" => user_id }, socket) do
    broadcast! socket, "new_message", %{body: body, user_id: user_id}
    {:noreply, socket}
  end

  def handle_in("typing", %{ "user_id" => user }, socket) do
    broadcast! socket, "typing", %{body: user}
    {:noreply, socket}
  end
end
