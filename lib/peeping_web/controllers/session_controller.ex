defmodule PeepingWeb.SessionController do
  use PeepingWeb, :controller

  def index(conn, _params) do
    conn
    |> json(%{status: "OK"})
  end
end