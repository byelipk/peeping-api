defmodule Peeping.Factory do
  use ExMachina.Ecto, repo: Peeping.Repo

  def room_factory do
    %Peeping.Chats.Room {
      name: sequence(:name, &"room-#{&1}"),
      owner: build(:user)
    }
  end

  def user_factory do
    %Peeping.User {
      email: sequence(:email, &"email-#{&1}@peeping.com"),
      password: "secretpass",
      password_confirmation: "secretpass"
    }
  end
end
