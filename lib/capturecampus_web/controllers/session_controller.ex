defmodule CapturecampusWeb.SessionController do
  use CapturecampusWeb, :controller

  alias Capturecampus.Account
  alias Capturecampus.Games

  def login(conn, %{"invite_code" => invite_code}) do
    game = Games.get_game_by_code!(invite_code)

    if game do
      conn
      |> put_session(:game_id, game.id)
      |> put_flash(:info, "Joined game #{game.invite_code}.")
      |> redirect(to: page_path(conn, :joingamesetup))
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
