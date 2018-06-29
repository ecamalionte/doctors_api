defmodule DoctorsApi.Channel do
  use DoctorsApi.Web, :model

  alias DoctorsApi.User
  alias DoctorsApi.UserChannel

  schema "channels" do
    field :name, :string

    timestamps()

    many_to_many :users, User, join_through: UserChannel
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
