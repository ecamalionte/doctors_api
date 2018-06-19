defmodule DoctorsApi.Channel do
  use DoctorsApi.Web, :model

  schema "channels" do
    field :name, :string

    timestamps()

    many_to_many :users, DoctorsApi.User, join_through: "users_channels"
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
