defmodule PeepingWeb.RegistrationController do
  use PeepingWeb, :controller

  alias Peeping.{Repo, User}

  def create(conn, %{"data" => %{ 
    "attributes" => %{
      "email" => email,
      "password" => password,
      "password-confirmation" => password_confirmation 
    }, "type" => "users" }}) do
      
    changeset = User.changeset(%User{}, %{
      email: email, 
      password: password, 
      password_confirmation: password_confirmation
    })

    case Repo.insert changeset do
      {:ok, user} ->
        conn
        |> put_status(201)
        |> render(PeepingWeb.UserView, "show.json", user: user)
      
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(PeepingWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def create(conn, _params) do
    conn
    |> put_status(422)
    |> render(PeepingWeb.ErrorView, "422.json", %{message: "Invalid registration request."})
  end
end