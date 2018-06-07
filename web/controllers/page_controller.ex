defmodule DoctorsApi.PageController do
  use DoctorsApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
