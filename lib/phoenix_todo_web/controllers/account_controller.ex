defmodule PhoenixTodoWeb.AccountController do
  use PhoenixTodoWeb, :controller
  require Logger
  alias PhoenixTodo.Account
  alias PhoenixTodoWeb.Auth

  def index(conn, _opts) do
    changeset = Account.User.changeset(%Account.User{}, %{})
    render(conn, "index.html", changeset: changeset)
  end

  def login(conn, _opts) do
    changeset = Account.User.changeset(%Account.User{}, %{})
    render(conn, "login.html", changeset: changeset)
  end

  def new(conn, %{"user" => %{"email" => email, "password" => password}}) do
    Logger.warn("email is , #{email}, #{password}")

    case Account.authenticate_by_email_password(email, password) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "#{user.email} login successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Email or password is wrong")
        |> render("login.html", changeset: %Ecto.Changeset{})

      {:error, :not_found} ->
        conn
        |> put_flash(:error, "Account doesn't exists!")
        |> render("login.html", changeset: %Ecto.Changeset{})
    end
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
        |> put_flash(:error, "Account creation failed.")
        |> render("index.html", changeset: changeset)
    end
  end
end
