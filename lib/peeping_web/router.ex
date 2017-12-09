defmodule PeepingWeb.Router do
  use PeepingWeb, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  pipeline :api_auth do
    plug :accepts, ["json", "json-api"]

    plug Guardian.Plug.Pipeline,
      module: Peeping.Guardian,
      error_handler: PeepingWeb.AuthErrorController

    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  scope "/api", PeepingWeb do
    pipe_through :api

    post "/token", SessionController, :create, as: :login

    resources "/session", SessionController, only: [:index]
    resources "/register", RegistrationController, only: [:create]
  end

  scope "/api", PeepingWeb do
    pipe_through :api_auth

    get "/user/current", UserController, :current
  end
end
