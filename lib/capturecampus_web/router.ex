defmodule CapturecampusWeb.Router do
  use CapturecampusWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CapturecampusWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/instructions", PageController, :instructions
    resources "/affiliations", AffiliationController
    resources "/buildings", BuildingController
    resources "/users", UserController
    resources "/games", GameController

  end

  # Other scopes may use custom stacks.
  # scope "/api", CapturecampusWeb do
  #   pipe_through :api
  # end
end
