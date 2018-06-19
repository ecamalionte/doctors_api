defmodule DoctorsApi.User do
  use DoctorsApi.Web, :model

  schema "users" do
    field :name, :string
    field :login, :string
    field :email, :string
    field :password, :string

    timestamps()

    many_to_many :channels, DoctorsApi.Channel, join_through: "users_channels"
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :login, :email, :password])
    |> validate_required([:name, :login, :email, :password])
  end
end
