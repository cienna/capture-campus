defmodule Capturecampus.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Capturecampus.Account.User
  alias Capturecampus.Games.Game
  alias Capturecampus.Team.Affiliation


  schema "users" do
    field :owner?, :boolean, default: false
    field :username, :string

    belongs_to :team, Affiliation
    belongs_to :game, Game

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :owner?])
    |> validate_required([:username, :owner?])
  end
end
