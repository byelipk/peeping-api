defmodule PeepingWeb.Router do
  use PeepingWeb, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/api", PeepingWeb do
    pipe_through :api

    resources "/session", SessionController, only: [:index]
    resources "/register", RegistrationController, only: [:create]
  end
end
