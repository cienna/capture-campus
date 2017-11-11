defmodule Capturecampus.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :start_time, :utc_datetime
      add :invite_code, :string
      add :active?, :boolean, default: false, null: false
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:games, [:owner_id])
  end
end
