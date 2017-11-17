defmodule Capturecampus.Repo.Migrations.CreateBuildings do
  use Ecto.Migration

  def change do
    create table(:buildings) do
      add :name, :string, null: false
      add :abbrev, :string, null: false
      add :lat, :float, null: false
      add :long, :float, null: false
      add :address, :string, null: false
      add :image_path, :string

      timestamps()
    end
  end
end
