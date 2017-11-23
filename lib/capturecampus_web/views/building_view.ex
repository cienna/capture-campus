defmodule CapturecampusWeb.BuildingView do
  use CapturecampusWeb, :view

  # from https://medium.com/@kaisersly/render-different-formats-in-phoenix-514aaf832a1a
  def render("index.json", %{buildings: buildings}) do
    buildings
    |> Enum.map(fn building -> Map.take(building, [:name, :abbrev, :lat, :long, :image_path]) end)
  end
end
