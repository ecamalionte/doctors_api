defmodule DoctorsApi.Router do
  use DoctorsApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", DoctorsApi do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
  end


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

  scope "/api", DoctorsApi do
    pipe_through :api
  end

  # Maybe logged in routes
  scope "/api", DoctorsApi do
    pipe_through [:api, :auth]

    get "/", WelcomeApiController, :index
    post "/register", UserController, :create
    post "/login", SessionsController, :create
  end

  # Definitely logged in routes
  scope "/api", DoctorsApi do
    pipe_through [:api, :auth, :ensure_authenticated]
    resources "/users", UserController
    delete "/logout", SessionsController, :delete
  end
end
