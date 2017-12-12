defmodule Peeping.ChatsTest do
  use Peeping.DataCase

  alias Peeping.Chats

  import Peeping.Factory

  describe "rooms" do
    alias Peeping.Chats.Room

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def room_fixture() do
      insert(:room)
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Enum.map(Chats.list_rooms(), &(&1.id)) == [room.id]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Chats.get_room!(room.id).id == room.id
    end

    test "create_room/1 with valid data creates a room" do
      user = insert(:user)
      attrs = Map.merge(@valid_attrs, %{owner_id: user.id})
      assert {:ok, %Room{} = room} = Chats.create_room(attrs)
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, room} = Chats.update_room(room, @update_attrs)
      assert %Room{} = room
      assert room.name == "some updated name"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_room(room, @invalid_attrs)
      assert room.id == Chats.get_room!(room.id).id
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Chats.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Chats.change_room(room)
    end
  end
end
