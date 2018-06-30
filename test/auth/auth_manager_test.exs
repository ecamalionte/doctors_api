
defmodule DoctorsApi.AuthManagerTest do
  use DoctorsApi.ConnCase
  import DoctorsApi.Factory
  alias DoctorsApi.{ AuthManager, Guardian }

  describe "user_id_by_token" do
    test "extract user_id by token" do
      user = insert(:doctor)
      {:ok, token, _}  = Guardian.encode_and_sign(user)
      {:ok, user_id} = AuthManager.user_id_by_token(token)
      assert user_id == user.id
    end

    test "invalid token" do
      invalid_token = "invalid token"
      resp = AuthManager.user_id_by_token(invalid_token)
      assert resp == {
        :error,
        %ArgumentError{message: "argument error: [\"invalid token\"]"}
      }
    end
  end

  describe "authenticate_channel" do
    test "join only user associated with channel" do
      channel = insert(:user_channel)
      user = List.first(channel.users)

      resp = AuthManager.authenticate_channel(channel.id, user.id)
      assert resp == {:ok, :authorized }
    end

    test "unauthorize user" do
      channel = insert(:channel)
      user = insert(:doctor)

      resp = AuthManager.authenticate_channel(channel.id, user.id)
      assert resp == {:error, :unauthorized}
    end

    test "invalid user" do
      channel_id = 1
      user_id = 0
      resp = AuthManager.authenticate_channel(channel_id, user_id)
      assert resp == {:error, :invalid_user}
    end

    test "invalid channel" do
      user = insert(:doctor)
      channel_id = nil
      resp = DoctorsApi.AuthManager.authenticate_channel(channel_id, user.id)
      assert resp == {:error, :invalid_channel}
    end
  end
end
