defmodule DoctorsApi.RoomChannel do
  use Phoenix.Channel

  def join("room:" <> channel_id, %{"token" => token}, socket) do
    {:ok, claims} = DoctorsApi.Guardian.decode_and_verify(token)
    user_id = claims["sub"]
    case Guardian.Phoenix.Socket.authenticate(socket, DoctorsApi.Guardian, token) do
      {:ok, authed_socket} -> {:ok, authed_socket}
      {:error, reason} -> { :error, reason: reason }
    end
  end

  def join(room, _params, socket), do: {:error, %{reason: "token not found"}}

  def handle_in("new_message", %{ "body" => body, "user" => user }, socket) do
    broadcast! socket, "new_message", %{body: body, user: user}
    {:noreply, socket}
  end

  def handle_in("typing", %{ "user" => user }, socket) do
    broadcast! socket, "typing", %{user: user}
    {:noreply, socket}
  end
end
