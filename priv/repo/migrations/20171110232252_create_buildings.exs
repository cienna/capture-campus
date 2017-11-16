defmodule Capturecampus.Repo.Migrations.CreateBuildings do
  use Ecto.Migration

  def change do
    create table(:buildings) do
      add :name, :string
      add :abbrev, :string
      add :lat, :float
      add :long, :float
      add :address, :string
      add :image_path, :string

      timestamps()
    end
  end
end
