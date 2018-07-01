defmodule DoctorsApi.RoomChannelTest do
  use Phoenix.ChannelTest
  use DoctorsApi.ChannelCase
  import DoctorsApi.Factory

  alias DoctorsApi.{Guardian, UserSocket}

  test "joining a channel" do
    channel = insert(:user_channel)
    user = List.first(channel.users)
    {:ok, token, _} = Guardian.encode_and_sign(user)

     {:ok, socket} = connect(UserSocket, %{"token" => token})
     {:ok, _, socket} = subscribe_and_join(socket, "room:#{channel.id}", %{"token" => token})
     assert socket.joined == true
     assert socket.assigns.guardian_default_claims["sub"] == Integer.to_string(user.id)
     assert socket.assigns.guardian_default_resource.name == user.name
  end
end
