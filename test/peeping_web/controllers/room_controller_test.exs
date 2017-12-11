defmodule PeepingWeb.RoomControllerTest do
  use PeepingWeb.ConnCase

  alias Peeping.Chats
  alias Peeping.Chats.Room
  alias Peeping.User
  alias Peeping.Repo

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:room, %{owner_id: owner_id}) do
    attrs = Map.merge(@create_attrs, %{owner_id: owner_id})
    {:ok, room} = Chats.create_room(attrs)
    room
  end

  setup %{conn: conn} do
    user = 
      %User{}
        |> User.changeset(%{email: "test@example.com", password: "secretpass", password_confirmation: "secretpass"})
        |> Repo.insert!

    conn = authenticate(conn, user)

    {:ok, conn: conn, current_user: user}
  end

  describe "index" do
    test "lists all rooms", %{conn: conn} do
      conn = get conn, room_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "show room" do
    setup [:create_room]

    test "renders room if room exists", %{conn: conn, room: room} do
      conn = get conn, room_path(conn, :show, room.id)
      assert json_response(conn, 200)["data"]["id"] == room.id
    end

    test "renders not found if room does not exist", %{conn: conn, room: _room} do
      assert_error_sent 404, fn ->
        conn = get conn, room_path(conn, :show, -1)
      end
    end
  end

  describe "delete room" do
    setup [:create_room]

    test "deletes chosen room", %{conn: conn, room: room, current_user: current_user} do
      conn = delete conn, room_path(conn, :delete, room)
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        conn = conn |> authenticate(current_user)
        get conn, room_path(conn, :show, room)
      end
    end
  end

  describe "create room" do
    test "renders room when data is valid", %{conn: conn, current_user: current_user} do
      conn = post conn, room_path(conn, :create), room: Map.merge(@create_attrs, %{owner_id: current_user.id})
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = authenticate(conn, current_user)
      conn = get conn, room_path(conn, :show, id)
      assert json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, room_path(conn, :create), room: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update room" do
    setup [:create_room]

    test "renders room when data is valid", %{conn: conn, room: %Room{id: id} = room, current_user: current_user} do
      conn = put conn, room_path(conn, :update, room), room: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = authenticate(conn, current_user)
      conn = get conn, room_path(conn, :show, id)
      assert json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, room: room} do
      conn = put conn, room_path(conn, :update, room), room: @invalid_attrs
      assert json_response(conn, 422)
    end
  end

  defp create_room(context) do
    room = fixture(:room, %{owner_id: context.current_user.id})
    {:ok, room: room}
  end

  defp authenticate(conn, user) do
    # Encode a token for the user
    {:ok, jwt, _claims} = Peeping.Guardian.encode_and_sign(user)
    
    conn = 
      conn
      |> recycle()
      |> put_req_header("content-type", "application/vnd.api+json") 
      |> put_req_header("authorization", "Bearer #{jwt}") 
    
    conn
  end
end
