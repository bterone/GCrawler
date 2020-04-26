defmodule GCrawlerWeb.Router do
  use GCrawlerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GCrawlerWeb.Plugs.SetCurrentUser
  end

  pipeline :authentication do
    plug GCrawlerWeb.Plugs.EnsureAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GCrawlerWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/registrations", UserController, only: [:create, :new]

    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete
  end

  scope "/", GCrawlerWeb do
    pipe_through [:browser, :authentication]
  end

  # Other scopes may use custom stacks.
  # scope "/api", GCrawlerWeb do
  #   pipe_through :api
  # end
end
