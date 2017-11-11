defmodule Capturecampus.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Capturecampus.Account.User


  schema "users" do
    field :owner?, :boolean, default: false
    field :username, :string
    field :team, :id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :owner?])
    |> validate_required([:username, :owner?])
  end
end
