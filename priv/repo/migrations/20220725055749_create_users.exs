defmodule PhoenixTodo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :pass_hash, :string
      add :username, :string

      timestamps()
    end
  end
end
