defmodule Capturecampus.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :owner?, :boolean, default: false, null: false
      add :team_id, references(:affiliations, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:team_id])
  end
end
