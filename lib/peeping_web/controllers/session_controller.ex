defmodule PeepingWeb.SessionController do
  use PeepingWeb, :controller

  import Ecto.Query, only: [where: 2]
  # import Logger

  alias Peeping.{Repo,User}

  def index(conn, _params) do
    conn
    |> json(%{status: "OK"})
  end

  def create(conn, %{"grant_type" => "password", "username" => username, "password" => password}) do
    case User |> where(email: ^username) |> Repo.one do
      nil ->
        conn
        |> put_status(404)
        |> render(PeepingWeb.ErrorView, "404.json")

      user ->
        cond do
          Comeonin.Pbkdf2.checkpw(password, user.password_hash) ->
            {:ok, token, _claims} = Peeping.Guardian.encode_and_sign(user)

            conn
            |> json(%{access_token: token})
            
          true -> 
            conn
            |> put_status(401)
            |> render(PeepingWeb.ErrorView, "401.json")
        end
    end
  end

  def create(conn, %{"grant_type" => _}) do
    conn
    |> put_status(422)
    |> render(PeepingWeb.ErrorView, "422.json", %{message: "Unsupported grant_type"})
  end
end