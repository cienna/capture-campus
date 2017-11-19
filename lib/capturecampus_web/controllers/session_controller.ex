defmodule CapturecampusWeb.SessionController do
  use CapturecampusWeb, :controller

  alias Capturecampus.Account
  alias Capturecampus.Games

  def login(conn, %{"username" => username}) do
    user = Account.get_user_by_username(username)

    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Hello #{user.username}.")
    end
  end

  def join_game(conn, %{"invite_code" => code}) do
    game = Games.get_game_by_code!(code)

    if game do
      conn
      |> put_session(:game_id, game.id)
      |> put_flash(:info, "Joined game #{game.invite_code}.")
      |> redirect(to: page_path(conn, :gamelanding))
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
