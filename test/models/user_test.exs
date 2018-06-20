defmodule DoctorsApi.UserTest do
  use DoctorsApi.ModelCase

  alias DoctorsApi.User

  @valid_attrs %{email: "some content", login: "some content", name: "some content", password: "some content"}
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
    changeset = User.changeset(%User{}, @valid_attrs)
    user = Repo.insert!(changeset)
           |> Repo.preload([:channels])
    assert user.channels == []
  end
end
