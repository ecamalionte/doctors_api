defmodule DoctorsApi.UserChannel do
  use DoctorsApi.Web, :model

  alias DoctorsApi.User
  alias DoctorsApi.Channel

  schema "users_channels" do
    belongs_to :user, User
    belongs_to :channel, Channel

    timestamps()
  end

  @doc false
  def changeset(user_channel, attrs) do
    user_channel
    |> cast(attrs, [])
    |> validate_required([])
  end
end
