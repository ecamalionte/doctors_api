defmodule DoctorsApi.User do
  use DoctorsApi.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :login, :string
    field :password, :string

    timestamps()

    many_to_many :channels, DoctorsApi.Channel, join_through: "users_channels"
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :login, :password])
    |> validate_required([:name, :email, :login, :password])
  end
end
