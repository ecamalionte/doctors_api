defmodule DoctorsApi.User do
  use DoctorsApi.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :login, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()

    many_to_many :channels, DoctorsApi.Channel, join_through: "users_channels"
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  Create a password_hash field that will be stored on DataBase
  The field password lives just in memory. See virtual: true
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :login, :password])
    |> validate_required([:name, :email, :login, :password])
    |> unique_constraint(:login)
    |> put_password_hash
  end

  def put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ -> changeset
    end
  end
end
