defmodule Capturecampus.Repo.Migrations.CreateAffiliations do
  use Ecto.Migration

  def change do
    create table(:affiliations) do
      add :color, :string

      timestamps()
    end

  end
end
