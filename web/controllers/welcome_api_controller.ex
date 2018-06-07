defmodule DoctorsApi.WelcomeApiController do
  use DoctorsApi.Web, :controller

  def index(conn, _params) do

    json conn, "Welcome to doctors backend in Json!!!"
  end
end
