defmodule DoctorsApi.SessionsController do
  use DoctorsApi.Web, :controller

  alias DoctorsApi.{User, Guardian, AuthManager}

  def create(conn, %{ "login" => login, "password" => password}) do
    case AuthManager.authenticate_user(login, password) do
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
end
