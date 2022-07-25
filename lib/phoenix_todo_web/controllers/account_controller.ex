defmodule PhoenixTodoWeb.AccountController do
  use PhoenixTodoWeb, :controller

  def index(conn, _opts) do
    render(conn, "index.html")
  end
end
