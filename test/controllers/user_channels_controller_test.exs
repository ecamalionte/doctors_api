defmodule DoctorsApi.UserChannelsControllerTest do
  use DoctorsApi.ConnCase
  import DoctorsApi.Factory

  alias DoctorsApi.{Guardian, User}

  @user_valid_attrs %{
    name: "some content",
    email: "some content",
    login: "some content",
    password: "some content"
  }

  setup %{conn: conn} do
    user = insert(:doctor)
    new_conn = Guardian.Plug.sign_in(conn, user)
    put_req_header(new_conn, "accept", "application/json")
    put_req_header(new_conn, "authorization", "Bearer: #{Guardian.Plug.current_token(new_conn)}")
    {:ok, conn: new_conn}
  end

  test "lists all user channels on index", %{conn: conn} do
    channel = insert(:user_channel)
    user = channel.users |> List.first

    expected_response = [ %{"id" => channel.id,
                            "name" => channel.name,
                            "topic" => "room:#{channel.id}"}
                        ]

    conn = get conn, user_channels_path(conn, :index, user.id)
    assert json_response(conn, 200) == expected_response
  end
end
