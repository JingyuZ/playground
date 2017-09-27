defmodule LeanCoffeeWeb.Router do
  use LeanCoffeeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", LeanCoffeeWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/sessions", SessionController, only: [:create, :delete]
    post "/sessions/refresh", SessionController, :refresh
  end
end
