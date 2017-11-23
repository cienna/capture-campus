defmodule CapturecampusWeb.Router do
  use CapturecampusWeb, :router
  import CapturecampusWeb.Plugs


  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
    plug :fetch_game
    plug :fetch_team
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CapturecampusWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/instructions", PageController, :instructions
    get "/join", PageController, :join
    get "/new/game", PageController, :newgame
    get "/new/game/setup", PageController, :newgamesetup
    get "/join/game/setup", PageController, :joingamesetup
    get "/user/game/landing", PageController, :gamelanding
    resources "/affiliations", AffiliationController
    resources "/buildings", BuildingController
    resources "/users", UserController
    resources "/games", GameController
    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", CapturecampusWeb do
  #   pipe_through :api
  # end
end
