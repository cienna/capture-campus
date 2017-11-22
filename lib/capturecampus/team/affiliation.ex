defmodule Capturecampus.Team.Affiliation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Capturecampus.Team.Affiliation


  schema "affiliations" do
    field :color, :string, null: false
    field :image_path, :string, default: "http://i149.photobucket.com/albums/s71/dylancolesss/white-dot.png", null: false
    timestamps()
  end

  @doc false
  def changeset(%Affiliation{} = affiliation, attrs) do
    affiliation
    |> cast(attrs, [:color])
    |> validate_required([:color])
  end
end
