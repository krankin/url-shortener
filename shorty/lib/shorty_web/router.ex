defmodule ShortyWeb.Router do
  use ShortyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ShortyWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/:slug", PageController, :find
    post "/", PageController, :create
  end
end
