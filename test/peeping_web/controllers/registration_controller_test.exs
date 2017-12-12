defmodule Peeping.RegistrationControllerTest do
  use PeepingWeb.ConnCase

  alias Peeping.{Repo, User}

  @valid_attrs %{
    "email" => "mike@example.com",
    "password" => "fqhi12hrrfasf",
    "password-confirmation" => "fqhi12hrrfasf"
  }

  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when attrs are valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{data: %{type: "users", attributes: @valid_attrs}}

    assert json_response(conn, 201)
    assert Repo.get_by(User, email: @valid_attrs["email"])
  end

  test "does not create resource and renders errors when attrs are invalid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{data: %{type: "users", attributes: @invalid_attrs}}

    assert json_response(conn, 422)
  end

end