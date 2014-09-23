defmodule Fantastic.ApiRouter do
  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end


  post "/events" do
    {:ok, body, conn} = read_body(conn)
    data = Poison.decode!(body)

    # parsed_data = Event. data[:name]
    # {:ok, key} = Fantastic.Data.insert parsed_data
    send_resp conn, 200, Poison.encode!(%{key: "nuke"})
  end


  forward "/", to: Fantastic.NoRouteFoundRouter
end
