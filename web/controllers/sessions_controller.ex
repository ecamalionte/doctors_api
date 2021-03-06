defmodule DoctorsApi.SessionsController do
  use DoctorsApi.Web, :controller

  alias DoctorsApi.User
  alias DoctorsApi.Guardian

  def create(conn, %{ "login" => login, "password" => password}) do
    case authenticate(login, password) do
      {:ok, user} ->
        new_conn = Guardian.Plug.sign_in(conn, user)
        token = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> json(%{token: token})
      _ ->
        conn
        |> put_status(:unauthorized)
    end
  end

  def delete do
  end

  defp authenticate(login, password) do
    user = Repo.get_by(User, login: login)
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, :unauthorized}
    end
  end

  defp check_password(nil, _), do: false
  defp check_password(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password_hash)
  end
end
