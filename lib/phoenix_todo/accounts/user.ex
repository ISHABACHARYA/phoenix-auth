defmodule PhoenixTodo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :pass_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :pass_hash, :username])
    |> validate_required([:email, :pass_hash, :username])
  end
end
