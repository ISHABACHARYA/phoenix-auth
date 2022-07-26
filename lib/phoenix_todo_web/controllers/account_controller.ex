defmodule PhoenixTodoWeb.AccountController do
  use PhoenixTodoWeb, :controller
  require Logger
  alias PhoenixTodo.Account
  alias PhoenixTodoWeb.Auth

  def index(conn, _opts) do
    changeset = Account.User.registration_changeset(%Account.User{}, %{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    Logger.warn(user_params)

    case Account.register_user(%Account.User{}, user_params) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "#{user.email} created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Account created failed.")
        |> render("index.html", changeset: changeset)
    end
  end
end
