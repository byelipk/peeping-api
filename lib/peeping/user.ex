defmodule Peeping.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Peeping.User


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_format(:email, ~r{@})
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> hash_password
    |> unique_constraint(:email)
  end

  defp hash_password(%{valid?: false} = changeset), do: changeset
  defp hash_password(%{valid?: true} = changeset) do
    hashed = 
      changeset
      |> Ecto.Changeset.get_field(:password)
      |> Comeonin.Pbkdf2.hashpwsalt
    
    Ecto.Changeset.put_change(changeset, :password_hash, hashed)
  end
end
