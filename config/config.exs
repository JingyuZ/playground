# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lean_coffee,
  ecto_repos: [LeanCoffee.Repo]

# Configures the endpoint
config :lean_coffee, LeanCoffeeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pPuG6HHb9kySbb9bXg5ZcZC4Xs1zlqAtzva+Yv0VpJKB4rW3/t2xQHchogNLZQpT",
  render_errors: [view: LeanCoffeeWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LeanCoffee.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian
config :lean_coffee, LeanCoffee.Guardian,
  issuer: "LeanCoffeeApp",
  ttl: {30, :days},
  secret_key: Application.get_env(:lean_coffee, Guardian)[:secret_key]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
