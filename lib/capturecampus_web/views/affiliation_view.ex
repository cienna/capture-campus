defmodule CapturecampusWeb.AffiliationView do
  use CapturecampusWeb, :view

  def render("index.json", %{affiliations: affiliations}) do
    affiliations
    |> Enum.map(fn affiliation -> Map.take(affiliation, [:color]) end)
  end
end
