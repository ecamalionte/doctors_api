defmodule DoctorsApi.SessionsControllerTest do
  use DoctorsApi.ConnCase

  describe "#create" do
    test "guardian registration and login flow", %{conn: conn} do
      registration_params = %{
        user: %{
          name: "name",
          email: "email",
          login: "login",
          password: "secret"
        }
      }

      conn = post conn, "/api/accounts/register", registration_params

      login_params = %{
        login: "login",
        password: "secret"
      }

      conn = post conn, "/api/accounts/login", login_params
      token = json_response(conn, 201)["token"]
      assert String.length(token) > 300
    end

    test "unauthorized user", %{conn: conn} do
      login_params = %{
        login: "unknown_login",
        password: "secret"
      }

      conn = post conn, "/api/accounts/login", login_params
      assert conn.status == 401
    end
  end
end
