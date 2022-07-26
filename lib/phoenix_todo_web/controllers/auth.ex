defmodule PhoenixTodoWeb.Auth do
  import Plug.Conn
  alias PhoenixTodo.Account
  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    Logger.warn("user_id is #{user_id}")
    user = user_id && Account.get_user(user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  import Phoenix.Controller
  alias RumblWeb.Router.Helpers, as: Routes

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "you must be logged to access the page!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
