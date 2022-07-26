defmodule PhoenixTodo.Account do
  alias PhoenixTodo.Repo
  alias PhoenixTodo.Account.User

  def list_users() do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def create_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert!()
  end

  def register_user(%User{} = user, params \\ %{}) do
    user
    |> User.registration_changeset(params)
    |> Repo.insert()
  end

  def authenticate_by_email_password(email, password) do
    user = get_user_by(email: email)

    cond do
      user && Pbkdf2.verify_pass(password, user.pass_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
