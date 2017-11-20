defmodule Capturecampus.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Capturecampus.Games.Game
  alias Capturecampus.Games

  schema "games" do
    field :active?, :boolean, default: true
    field :invite_code, :string

    has_many :players, Capturecampus.Account.User

    timestamps()
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [])
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
    IO.puts("gen code")

    if Games.get_game_by_code(code) do
      IO.puts("repeat code; retry")
      gen_invite_code(changeset0)
    else
      IO.puts("OK new code")
      changeset = change(changeset0, %{invite_code: code})
      apply_changes(changeset)
      changeset
    end
  end

  def invite_exists(changeset0, invite_code) do
    #    IO.puts(invite_code)
    {_, test} = fetch_field(changeset0, :invite_code)
    if test do
      IO.puts(test)
    else
      IO.puts("nil")
    end
    if test do
      IO.puts("code exists")
      changeset= change(changeset0, %{invite_code: invite_code})
      apply_changes(changeset)
      changeset
    else
      IO.puts("new code")
      gen_invite_code(changeset0)
    end
  end
end
