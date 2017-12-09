defmodule PeepingWeb.UserController do
  use PeepingWeb, :controller

  def current(conn, _) do
    user = Peeping.Guardian.Plug.current_resource(conn)
    
    conn |> render(PeepingWeb.UserView, "show.json", user: user)
  end
end