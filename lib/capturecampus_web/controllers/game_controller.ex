defmodule CapturecampusWeb.GameController do
  use CapturecampusWeb, :controller

  alias Capturecampus.Games
  alias Capturecampus.Games.Game
  alias Capturecampus.Team

  def index(conn, _params) do
    games = Games.list_games()
    render(conn, "index.html", games: games)
  end

  def new(conn, _params) do
    changeset = Games.change_game(%Game{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"game" => game_params}) do
    black = Team.get_by_color("black")
    case Games.create_game(game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> put_session(:team_id, black.id)
        |> put_session(:game_id, game.id)
        |> put_flash(:info, "Joined game #{game.invite_code}.")
        |> redirect(to: page_path(conn, :newgamesetup))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    render(conn, "show.html", game: game)
  end

  def edit(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    changeset = Games.change_game(game)
    render(conn, "edit.html", game: game, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Games.get_game!(id)

    case Games.update_game(game, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: game_path(conn, :show, game))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", game: game, changeset: changeset)
    end
  end

  def join(conn, %{"invite_code" => invite_code}) do
    game = Games.get_game_by_code!(invite_code)

    if game do
      conn
      |> put_session(:game_id, game.id)
      |> put_flash(:info, "Joined game #{game.invite_code}.")
      |> redirect(to: page_path(conn, :joingamesetup))
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    {:ok, _game} = Games.delete_game(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> put_session(:user_id, nil)
    |> put_session(:game_id, nil)
    |> put_flash(:info, "Disconnected from game.")
    |> redirect(to: page_path(conn, :index))
  end
end
