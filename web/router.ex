defmodule Raffler.Router do
  use Raffler.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Raffler.Auth, repo: Raffler.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Raffler do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    resources "/session", SessionController, only: [:new, :create, :delete]
    resources "/raffles", RaffleController,  only: [:index, :show, :new, :create] do
      resources "/entrants", EntrantController, only: [:index, :new, :create]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Raffler do
  #   pipe_through :api
  # end
end
