defmodule DoctorsApi.WelcomeApiController do
  use DoctorsApi.Web, :controller

  def index(conn, _params) do
    response = %{ data: "Welcome to DoctorsApi in Json!!!" }
    json conn, response
  end
end
