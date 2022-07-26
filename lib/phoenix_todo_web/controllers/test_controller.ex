defmodule PhoenixTodoWeb.TestController do
  use PhoenixTodoWeb, :controller

  def index(conn, _params) do
    conn
    |> json(%{status: "ok"})
  end
end
