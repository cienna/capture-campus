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

    timestamps()
  end

  @doc false
  def changeset(%Building{} = building, attrs) do
    building
    |> cast(attrs, [:name, :abbrev, :lat, :long, :address, :image_path])
    |> get_coords()
    |> validate_required([:name, :abbrev, :lat, :long, :address, :image_path])
  end

  def get_coords(%Ecto.Changeset{changes: %{address: address}} = changeset) do
    lookup_address = convert_address(address)
    api_key = Application.get_env(:capturecampus, CapturecampusWeb.Endpoint)[:api_key]
    url = base_url() <> "geocode/json?address=" <> lookup_address <> "&key=" <> api_key
    resp = HTTPoison.get!(url)
    data = Poison.decode!(resp.body)

    format_coordinates(changeset, data)
  end
  def get_coords(changeset), do: changeset

  @doc """
  Converts a human-readable string address into the format necessary
  for a https Google API request.
  """
  def convert_address(address) do
    String.replace(address, " ", "+")
  end

  def base_url, do: "https://maps.googleapis.com/maps/api/"

  def format_coordinates(changeset0, google_data) do
    geo = hd(google_data["results"])["geometry"]

    lat =
      if geo["bounds"] do
        geo["bounds"]["northeast"]["lat"]
      else
        geo["location"]["lat"]
      end

    lng =
      if geo["bounds"] do
        geo["bounds"]["northeast"]["lng"]
      else
        geo["location"]["lng"]
      end

    changeset = change(changeset0, %{lat: lat, long: lng})
    apply_changes(changeset)
    changeset
  end
#    "Latitude: " <> Float.to_string(lat) <> "   Longitude: " <> Float.to_string(lng)
end
