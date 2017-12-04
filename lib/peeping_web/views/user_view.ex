defmodule PeepingWeb.UserView do
  use PeepingWeb, :view

  alias PeepingWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      type: "user",
      id: user.id,
      attributes: %{
        email: user.email
      }
    }
  end
end