require IEx

defmodule DoctorsApi.Api.AuthController do
  use DoctorsApi.Web, :controller

  def auth(conn, params) do

    if(params["credentials"]["login"] == "invalid") do
      conn = conn |> put_status(400)

      response = %{ errors: %{ login: "Is invalid" } }
      json conn, response
    else
      response = %{
        user: %{
          id: "some-id-#{params["credentials"]["login"]}",
          name: params["credentials"]["login"]
        },
        token: "some-token-#{params["credentials"]["login"]}"
      }
      json conn, response
    end
  end

  def auth_token(conn, params) do
    if(params["token"] == "some-token-") do
    # if(true) do
      conn = conn |> put_status(403)

      response = %{ errors: %{ token: "Is invalid" } }
      json conn, response
    else
      splited_token = String.split(params["token"], "-")
      splited_token_prefix = ["some", "token"]

      user_name =  splited_token -- splited_token_prefix
      response = %{
        user: %{
          id: "some-id-#{user_name}",
          name: user_name
        },
        token: "some-token-#{user_name}"
      }
      json conn, response
    end
  end
end
