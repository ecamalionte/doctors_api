defmodule DoctorsApi.Router do
  use DoctorsApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  scope "/", DoctorsApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", DoctorsApi do
    pipe_through :api

    get "/", WelcomeApiController, :index
    resources "/users", UserController, except: [:new, :edit]

    post "/sessions", SessionsController, :create #login
    delete "/sessions", SessionsController, :delete #logout
  end
end
