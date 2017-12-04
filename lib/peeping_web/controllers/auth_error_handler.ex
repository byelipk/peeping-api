defmodule PeepingWeb.AuthErrorHandler do
  use PeepingWeb, :controller

  def unauthenticated(conn, _params) do
    conn
     |> put_status(401)
     |> render(PeepingWeb.ErrorView, "401.json")
   end
  
   def unauthorized(conn, _params) do
    conn
     |> put_status(403)
     |> render(PeepingWeb.ErrorView, "403.json")
   end
end