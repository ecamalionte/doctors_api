defmodule DoctorsApi.RoomChannel do
  use Phoenix.Channel

  alias Guardian.Phoenix.Socket
  alias DoctorsApi.AuthManager

  def join("room:" <> channel_id, %{"token" => token}, socket) do
    channel_id = String.to_integer(channel_id)

    with {:ok, user_id} <- AuthManager.user_id_from_token(token),
         {:ok, _} <- AuthManager.authenticate_channel(channel_id, user_id),
         {:ok, authed_socket} <- Socket.authenticate(socket, DoctorsApi.Guardian, token)
      do
        {:ok, authed_socket}
      else
        error -> error
    end
  end

  def join(room, _params, socket), do: {:error, :token_not_found}

  def handle_in("new_message", %{ "body" => body, "user" => user }, socket) do
    broadcast! socket, "new_message", %{body: body, user: user}
    {:noreply, socket}
  end

  def handle_in("typing", %{ "user" => user }, socket) do
    broadcast! socket, "typing", %{user: user}
    {:noreply, socket}
  end
end
