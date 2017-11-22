defmodule Capturecampus.Repo.Migrations.AddPathsToAffiliations do
  use Ecto.Migration

  def change do
    alter table(:affiliations) do
      add :image_path, :string, default: "http://i149.photobucket.com/albums/s71/dylancolesss/white-dot.png", null: false      
    end
  end
end
