defmodule PeepingWeb.AuthErrorController do
  use PeepingWeb, :controller

  def auth_error(conn, {:unauthenticated, _reason}, _opts) do
    conn
     |> put_status(401)
     |> render(PeepingWeb.ErrorView, "401.json")
  end

  def auth_error(conn, {:unauthorized, _reason}, _opts) do
    conn
     |> put_status(403)
     |> render(PeepingWeb.ErrorView, "403.json")
  end

  def auth_error(conn, {:invalid_token, _reason}, _opts) do
    conn
     |> put_status(401)
     |> render(PeepingWeb.ErrorView, "401.json")
  end
end