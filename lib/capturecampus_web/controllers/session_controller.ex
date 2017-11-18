defmodule CapturecampusWeb.SessionController do
  use CapturecampusWeb, :controller

  alias Capturecampus.Accounts
  alias Capturecampus.Games

  def login(conn, %{"username" => username, "invite_code" => code}) do
    user = Accounts.get_user_by_username(username)
    game = Games.get_game_by_code(code)

    if user && game do
      conn
      |> put_session(:user_id, user.id)
      |> put_session(:game_id, game.id)
      |> put_flash(:info, "Joined game #{game.invite_code} as #{user.username}")
      |> redirect(to: page_path(conn, :lobby))
    end
  end

  def logout(conn, _args) do
    conn
    |> put_session(:user_id, nil)
    |> put_session(:game_id, nil)
    |> put_flash(:info, "Disconnected from game.")
    |> redirect(to: page_path(conn, :start))
  end
end
