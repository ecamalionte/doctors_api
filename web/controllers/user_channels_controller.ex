defmodule DoctorsApi.UserChannelsController do
  use DoctorsApi.Web, :controller

  alias DoctorsApi.{User, Channel}

  def index(conn, params) do
    user = Repo.get(User, params["user_id"]) |> Repo.preload(:channels)

    channels = Enum.map(
      user.channels, fn (chn) -> %{id: chn.id, name: chn.name} end
    )

    json conn, channels
  end
end
