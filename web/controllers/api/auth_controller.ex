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
end
