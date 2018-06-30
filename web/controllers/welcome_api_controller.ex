defmodule DoctorsApi.WelcomeApiController do
  use DoctorsApi.Web, :controller

  def index(conn, _params) do
    response = %{ message: "Welcome to DoctorsApi in Json!!!" }
    json conn, response
  end
end
