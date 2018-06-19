defmodule DoctorsApi.UserTest do
  use DoctorsApi.ModelCase

  alias DoctorsApi.User

  @valid_attrs %{name: "Fulano", login: "fulaninho", email: "ful@lano", password: "1234"}
  @invalid_attrs %{}

  test "Changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "Changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "Association with Channels" do
    IO.puts "pending"
  end
end
