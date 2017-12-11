defmodule PeepingWeb.RoomController do
  use PeepingWeb, :controller

  alias Peeping.Chats
  alias Peeping.Chats.Room

  action_fallback PeepingWeb.FallbackController

  def index(conn, _params) do
    rooms = Chats.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def show(conn, %{"id" => id}) do
    with room <- Chats.get_room!(id) do
      render(conn, "show.json", room: room)
    end
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- Chats.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", room_path(conn, :show, room))
      |> render("show.json", room: room)
    end
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Chats.get_room!(id)

    with {:ok, %Room{} = room} <- Chats.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    with room <- Chats.get_room!(id),
         { :ok, %Room{} } <- Chats.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
