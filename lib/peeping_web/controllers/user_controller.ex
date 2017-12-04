defmodule PeepingWeb.UserController do
  use PeepingWeb, :controller

  # alias Peeping.{Repo, User}

  # plug Guardian.Plug.EnsureAuthenticated, handler: Peeping.AuthErrorHandler

  def current(conn, _) do
    user = 
      conn
      |> Guardian.Plug.current_resource
    
    conn
    |> render(PeepingWeb.UserView, "show.json", user: user)
  end
end