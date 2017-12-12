defmodule Peeping.UserTest do
  use Peeping.DataCase

  alias Peeping.User

  @valid_attrs %{email: "pat@email.com", password: "secretpass", password_confirmation: "secretpass"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid? == true
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, %{})
    assert changeset.valid? == false
  end

  test "mis-matched password confirmation does not work" do
    changeset = User.changeset(%User{}, %{
      email: "pat@email.com",
      password: "secretpass",
      password_confirmation: "doesnotmatchpass"
    })
    assert changeset.valid? == false
  end

  test "missing password confirmation does not work" do
    changeset = User.changeset(%User{}, %{
      email: "pat@email.com",
      password: "secretpass",
      password_confirmation: ""
    })
    assert changeset.valid? == false
  end

  test "short password confirmation does not work" do
    changeset = User.changeset(%User{}, %{
      email: "pat@email.com",
      password: "secret",
      password_confirmation: "secret"
    })
    assert changeset.valid? == false 
  end
end