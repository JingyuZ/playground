defmodule LeanCoffeeWeb.Router do
  use LeanCoffeeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LeanCoffeeWeb do
    pipe_through :api
  end
end
