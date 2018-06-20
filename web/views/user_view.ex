defmodule DoctorsApi.UserView do
  use DoctorsApi.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, DoctorsApi.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, DoctorsApi.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      login: user.login,
      password: user.password}
  end
end
