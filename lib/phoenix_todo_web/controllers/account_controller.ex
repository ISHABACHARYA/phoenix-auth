defmodule PhoenixTodoWeb.AccountController do
  use PhoenixTodoWeb, :controller
  require Logger
  alias PhoenixTodo.Account.User

  def index(conn, _opts) do
    changeset = User.registration_changeset(%User{}, %{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    Logger.warn(user_params)

    conn
    |> put_flash(:info, "Video created successfully.")

    redirect(conn, to: Routes.page_path(conn, :index))
  end
end
