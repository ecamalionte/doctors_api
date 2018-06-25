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
  end

  scope "/", DoctorsApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", DoctorsApi do
    pipe_through :api
    get "/", WelcomeApiController, :index
    post "/auth", Api.AuthController, :auth
    post "/auth/token", Api.AuthController, :auth_token
  end
end
