defmodule DoctorsApi.SessionsControllerTest do
  use DoctorsApi.ConnCase
  import DoctorsApi.Factory

  alias DoctorsApi.Guardian

  test "guardian sign_in" do
    user = insert(:patient)

    newconn = Guardian.Plug.sign_in(build_conn(), user)
    IO.inspect newconn
  end
end
