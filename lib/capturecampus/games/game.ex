defmodule Capturecampus.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Capturecampus.Games.Game
  alias Capturecampus.Games

  schema "games" do
    field :active?, :boolean, default: true
    field :invite_code, :string

    belongs_to :owner, Capturecampus.Account.User
    has_many :players, Capturecampus.Account.User

    timestamps()
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:active?])
    |> invite_exists(:invite_code)
    |> validate_required([:invite_code, :active?, :owner])
  end

  # code from answer on https://stackoverflow.com/questions/32001606/how-to-generate-a-random-url-safe-string-with-elixir
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" |> String.split("", trim: true)

  def string_of_length(length) do
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(@chars) | acc]
    end) |> Enum.join("")
  end

  # Keep generating invite codes until a new/unique one is created
  def gen_invite_code(changeset0) do
    code = string_of_length(4)

    if Games.get_game_by_code(code) do
      gen_invite_code(changeset0)
    else
      changeset= change(changeset0, %{invite_code: code})
      apply_changes(changeset)
      changeset
    end
  end

  def invite_exists(changeset0, invite_code) do
        if String.valid?(invite_code) do
          changeset= change(changeset0, %{invite_code: invite_code})
          apply_changes(changeset)
          changeset
        else
          gen_invite_code(changeset0)
        end
  end
end
