defmodule FroggyWeb.Router do
  use FroggyWeb, :router

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

  scope "/", FroggyWeb do
    pipe_through :browser

    resources("/assignments", AssignmentController)

    get "/", PageController, :index
    post "/complete", PageController, :complete
  end

  # Other scopes may use custom stacks.
  # scope "/api", FroggyWeb do
  #   pipe_through :api
  # end
end
