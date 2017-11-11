defmodule Capturecampus.Campus.Building do
  use Ecto.Schema
  import Ecto.Changeset
  alias Capturecampus.Campus.Building


  schema "buildings" do
    field :abbrev, :string
    field :address, :string
    field :image_path, :string
    field :lat, :float
    field :long, :float
    field :name, :string
    field :color, :id

    timestamps()
  end

  @doc false
  def changeset(%Building{} = building, attrs) do
    building
    |> cast(attrs, [:name, :abbrev, :lat, :long, :address, :image_path])
    |> validate_required([:name, :abbrev, :lat, :long, :address, :image_path])
  end
end
