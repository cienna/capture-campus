defmodule CapturecampusWeb.SessionController do
  use CapturecampusWeb, :controller

  alias Capturecampus.Account
  alias Capturecampus.Games
  alias Capturecampus.Team

  def login(conn, %{"invite_code" => invite_code}) do
    game = Games.get_game_by_code!(invite_code)
    tblack = Team.get_by_color("black")
    tred = Team.get_by_color("red")

    black = Account.check_team(game.id, tblack.id)
    red = Account.check_team(game.id, tred.id)

    if game do
      if black < 5 do
        conn
        |> put_session(:game_id, game.id)
        |> put_session(:team_id, tblack.id)
        |> put_flash(:info, "Joined game #{game.invite_code}.")
        |> redirect(to: page_path(conn, :joingamesetup))
      end
      else if red < 5 do
        conn
        |>put_session(:game_id, game.id)
        |>put_session(:team_id, tred.id)
        |> put_flash(:info, "Joined game #{game.invite_code}.")
        |> redirect(to: page_path(conn, :joingamesetup))
      else
        conn
        |>put_flash(:error, "Game is Full")
        |> redirect(to: page_path(conn, :index))
      end
    end
  end

  def logout(conn, _args) do
    conn
    |> put_session(:user_id, nil)
    |> put_session(:game_id, nil)
    |> put_flash(:info, "Disconnected from game.")
    |> redirect(to: page_path(conn, :index))
  end
end
