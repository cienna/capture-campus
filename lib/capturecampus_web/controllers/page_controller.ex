defmodule CapturecampusWeb.PageController do
  use CapturecampusWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def instructions(conn, _params) do
    render conn, "instructions.html"
  end
  def join(conn, _params) do
    render conn, "join.html"
  end

  def newgame(conn, _params) do
    changeset = Capturecampus.Account.change_user(%Capturecampus.Account.User{})
    render(conn, "newgame.html", changeset: changeset)
  end

  def newgamesetup(conn, _params) do
    changeset = Capturecampus.Games.change_game(%Capturecampus.Games.Game{})
    render(conn, "newgamename.html", changeset: changeset)
  end

  def gamelanding(conn, _params) do
    render conn, "gamelanding.html"
    |>Capturecampus.Repo.preload([:user, :game])
  end
end
