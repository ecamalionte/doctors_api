defmodule DoctorsApi.WelcomeApiController do
  use DoctorsApi.Web, :controller

  def index(conn, _params) do
    response = %{ data: "Welcome to DoctorsApi in Json!!!" }
    json allow_cors(conn), response
  end

  defp allow_cors(conn), do: put_resp_header(conn, "Access-Control-Allow-Origin", "*")
end
