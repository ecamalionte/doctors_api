defmodule DoctorsApi.UserTest do
  use DoctorsApi.ModelCase

  alias DoctorsApi.User

  @valid_attrs %{email: "some content", login: "some content", name: "some content", password: "mysecretpass"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "association with Channels" do
    user = User.changeset(%User{}, @valid_attrs)
    |> Repo.insert!
    |> Repo.preload([:channels])
    assert user.channels == []
  end

  test "create a password hash when the user is created" do
    user = User.changeset(%User{}, @valid_attrs)
    |> Repo.insert!

    assert user.password == "mysecretpass"
    assert Comeonin.Bcrypt.checkpw(user.password, user.password_hash)
  end
end
