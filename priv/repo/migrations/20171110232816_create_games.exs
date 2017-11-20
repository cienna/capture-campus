defmodule Capturecampus.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :invite_code, :string, null: false
      add :active?, :boolean, default: true, null: false

      timestamps()
    end

  end
end
