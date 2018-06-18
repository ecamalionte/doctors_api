defmodule DoctorsApi.Channel do
  use Ecto.Schema

  schema "channels" do
    field :name, :string

    many_to_many :users, DoctorsApi.User, join_through: "users_channels"
  end
end
