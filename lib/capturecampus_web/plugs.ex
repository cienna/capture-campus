defmodule Capturecampus.Plugs do
  import Plug.Conn

  def fetch_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Capturecampus.Account.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  def fetch_game(conn, _opts) do
    game_id = get_session(conn, :game_id)
    if game_id do
      game = Capturecampus.Games.get_game!(game_id)
      assign(conn, :current_game, game)
    else
      assign(conn, :current_game, nil)
    end
  end
end
