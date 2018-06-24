defmodule DoctorsApi.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias DoctorsApi.Repo
  alias DoctorsApi.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_toker(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Repo.get(User, String.to_integer(id))}
  def from_toker(_), do: {:error, "Unknown resource type"}
end

defmodule DoctorsApi.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, reason}, _opts) do
    body = Poison.encode!(%{message: to_string(type)})
    send_resp(conn, 401, body)
  end
end
