defmodule DoctorsApi.ChannelTest do
  use DoctorsApi.ModelCase

  alias DoctorsApi.Channel

  @valid_attrs %{name: "Some Channel"}
  @invalid_attrs %{}

  test "Changeset with valid attributes" do
    changeset = Channel.changeset(%Channel{}, @valid_attrs)
    assert changeset.valid?
  end

  test "Changeset with invalid attributes" do
    changeset = Channel.changeset(%Channel{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "Association with Users" do
    IO.puts "pending"
  end
end
