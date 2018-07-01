defmodule DoctorsApi.Router do
  use DoctorsApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # this is a "maybe" authenticated pipeline
  pipeline :auth do
    plug DoctorsApi.Guardian.AuthPipeline
  end

  # Use ensure auth to fail if there is no one logged in
  pipeline :ensure_authenticated do
    plug Guardian.Plug.EnsureAuthenticated
  end

  # Maybe logged in routes
  scope "/api", DoctorsApi do
    pipe_through [:api, :auth]

    get "/", WelcomeApiController, :index
    post "/accounts/register", UserController, :create
    post "/accounts/login", SessionsController, :create
  end

  # Definitely logged in routes
  scope "/api", DoctorsApi do
    pipe_through [:api, :auth, :ensure_authenticated]

    resources "/users", UserController do
      resources "/channels", UserChannelsController, only: [:index], as: :channels
    end
  end
end
