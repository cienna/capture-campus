defmodule Capturecampus.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Capturecampus.Games.Game


  schema "games" do
    field :active?, :boolean, default: false
    field :invite_code, :string
    field :start_time, :utc_datetime
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:start_time, :invite_code, :active?])
    |> validate_required([:start_time, :invite_code, :active?])
  end
end
