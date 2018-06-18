defmodule DoctorsApi.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :login, :string
    field :email, :string
    field :password, :string

    many_to_many :channels, DoctorsApi.Channel, join_through: "users_channels"
  end
end
