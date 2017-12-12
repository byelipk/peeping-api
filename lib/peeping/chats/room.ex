defmodule Peeping.Chats.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Peeping.Chats.Room

  schema "rooms" do
    field :name, :string
    # field :owner_id, :id
    belongs_to :owner, Peeping.User

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name, :owner_id])
    |> foreign_key_constraint(:owner_id)
    |> validate_required([:name, :owner_id])
  end
end
