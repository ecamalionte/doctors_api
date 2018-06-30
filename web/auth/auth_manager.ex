defmodule DoctorsApi.AuthManager do
  alias DoctorsApi.{Repo, User, Channel, Guardian}


  def user_id_from_token(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, %{"sub" => user_id}} -> {:ok, String.to_integer(user_id)}
      error -> error
    end
  end

  def user_from_token(token) do
    Guardian.resource_from_token(token)
  end

  def authenticate_user(login, password) do
    user = Repo.get_by(User, login: login)
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, :unauthorized}
    end
  end

  def authenticate_channel(channel_id, user_id) do
    user = Repo.get(User, user_id)
    |> Repo.preload(:channels)

    case has_association?(user, channel_id) do
      true -> {:ok, :authorized}
      false -> {:error, :unauthorized}
      error -> error
    end
  end

  defp has_association?(nil, _) do {:error, :invalid_user} end
  defp has_association?(_, nil) do {:error, :invalid_channel} end
  defp has_association?(user, channel_id) do
    Enum.any?(user.channels, fn(channel) -> channel.id == channel_id end)
  end

  defp check_password(nil, _), do: false
  defp check_password(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password_hash)
  end
end
